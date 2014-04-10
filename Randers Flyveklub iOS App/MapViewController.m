//
//  MapViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Daniel Otkjær on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "MapViewController.h"
#import "Airfield.h"
#import "sqlite3.h"
#import "AppDelegate.h"

@interface MapViewController ()

@end

@implementation MapViewController
{
    GMSMapView *mapView_;
    
	// Global variables for SQLite
	NSString       *db;             // Database name string
	sqlite3        *dbh;            // Database handle
	sqlite3_stmt   *stmt_query;     // Select statement handle
	NSMutableArray *data;           // Container for data returned from query
    
    
    CLLocation *userlocation;       // Users Location
    GMSVisibleRegion region;        // Vissible Area of Map
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    mapView_.mapType = kGMSTypeSatellite;
    mapView_.indoorEnabled = NO;
    mapView_.myLocationEnabled = YES;

    
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:0 context:nil];

    NSLog(@"User's location: %@", mapView_.myLocation);
    NSLog(@"User's location: %f", mapView_.myLocation.altitude);
    NSLog(@"User's location: %f", mapView_.myLocation.speed);

    
    self.view = mapView_;
		
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.distanceFilter = kCLDistanceFilterNone; // Update whenever we move
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // Location Accuracy
	[self.locationManager startUpdatingLocation];
    

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: userlocation.coordinate.latitude
                                                            longitude: userlocation.coordinate.longitude
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    [self performSelector:@selector(contactdatabase) withObject:self afterDelay:2.0 ];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        userlocation = [object myLocation];
        //...
        NSLog(@"User's latitude: %f", userlocation.coordinate.latitude);
        NSLog(@"User's longitude: %f", userlocation.coordinate.longitude);
        NSLog(@"User's altitude: %f", userlocation.altitude);
        NSLog(@"User's speed: %f", userlocation.speed);
        
    }
}

-(void)makeregion
{
//    nearleft = &region.nearLeft;
//    nearright = &region.nearRight;
//    farleft = &region.farLeft;
//    farright = &region.farRight;
}

-(void)contactdatabase
{
	// Allocate array to hold data from data storage
	data = [[NSMutableArray alloc] init];
	
	// Copy SQlite database from App-bundle to Sandbox
	db = [self copyResource:@"airfields" ofType:@"rdb"];
	NSLog(@"Path to database: %@", db);
	
	// Open database
	if (sqlite3_open_v2([db UTF8String], &dbh, SQLITE_OPEN_READWRITE, NULL) == SQLITE_OK)
	{
		NSLog(@"DB Opened");
		// Reset statements
		stmt_query = nil;
		
		if (!stmt_query)
		{
			// Prepare SQL select statement
			NSString *sql = @"SELECT name, icao, country, latitude, longitude FROM airfields";
			NSLog(@"Query: %@", sql);
			if (sqlite3_prepare_v2(dbh, [sql UTF8String], -1, &stmt_query, nil) != SQLITE_OK)
			{
				int errmsg = sqlite3_prepare_v2(dbh, [sql UTF8String], -1, &stmt_query, nil);
				NSLog(@"Error preparing SQL query. ERROR %d", errmsg);
				NSLog(@"%s SQL error '%s' (%1d)", __FUNCTION__, sqlite3_errmsg((__bridge sqlite3 *)(db)), sqlite3_errcode((__bridge sqlite3 *)(db)));
			}
		}
		
		// Reset state of query statement
		sqlite3_reset(stmt_query);
		
		// Fetch selected rows in airfields table and populate data array
		NSLog(@"Loading airfields ...");
		while (sqlite3_step(stmt_query) == SQLITE_ROW)
		{
			// Create airfield object and set properties
			Airfield *airfield = [[Airfield alloc] init];
			airfield.name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 0)];
			airfield.icao = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 1)];
			airfield.country = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 2)];
			airfield.latitude = (double) sqlite3_column_double(stmt_query, 3);
			airfield.longitude = (double) sqlite3_column_double(stmt_query, 4);
			
			// Append Airfield object to data array
			[data addObject:airfield];
            //NSLog(@"Airfield added");
		}
		NSLog(@"Airfields loaded");
		
		sqlite3_finalize(stmt_query);
		sqlite3_close(dbh);
		NSLog(@"DB Closed");
	}
	else
	{
		NSLog(@"Error: Could not open database");
	}
    

        [self performSelectorInBackground:@selector(placepins) withObject:nil];
//        [self performSelector:@selector(placepins) withObject:self afterDelay:2.0 ];
}

-(void)placepins
{
    usleep(1000000);
    // Run through airfield array and place pins in this region
	for (Airfield *airfield in data)
	{
        if ((airfield.latitude <= region.farLeft.latitude && airfield.longitude >= region.farLeft.longitude) && (airfield.latitude >= region.nearRight.latitude && airfield.longitude <= region.nearRight.longitude)) {
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(airfield.latitude, airfield.longitude);
            marker.title = airfield.name;
            marker.snippet = airfield.icao;
            marker.map = mapView_;
        }

	}
	NSLog(@"All pins placed");
}

// Copy a named resource from bundle to Documents/Data
- (NSString *)copyResource:(NSString *)resource ofType:(NSString *)type
{
	NSLog(@"Copying %@.%@ to Sandbox...", resource, type);
	
	// Find path to Sandbox Documents
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	//NSLog(@"docDir: %@", docDir);
	
	// Find named resource in bundle
	NSString *srcDb = [[NSBundle mainBundle] pathForResource:resource ofType:type];
	
	//NSLog(@"Main bundle dir: %@", [NSBundle mainBundle]);
	//NSLog(@"srcDb: %@", srcDb);
	
	// Build path to "Data" subdirectory in Sandbox Documents
	NSString *dstDir = [docDir stringByAppendingPathComponent:@"Data"];
	//NSLog(@"dstDir: %@", dstDir);
	
	// Build basename to resource in Sandbox Documents/Data
	NSString *dstBase = [dstDir stringByAppendingPathComponent:resource];
	//NSLog(@"dstBase: %@", dstBase);
	
	// Append resource extension to build full path to resource "Documents/Data/resource.type"
	NSString *dstDb = nil;
	dstDb = [dstBase stringByAppendingPathExtension:type];
	//NSLog(@"dstDb: %@", dstDb);
	
	NSError *error = nil;
	BOOL isDirectory = false;
	
	// Test if "Data" subdirectory exists in Sandbox "Documents"
	if (![[NSFileManager defaultManager] fileExistsAtPath:dstDir isDirectory:&isDirectory])
	{
		NSLog(@"Path /Documents/Data does not exist");
		
		// Create "Data" subdirecotory
		NSLog(@"Creating Data subdirectory...");
		if (![[NSFileManager defaultManager] createDirectoryAtPath:dstDir withIntermediateDirectories:YES attributes:nil error:&error])
			NSLog(@"Error creating directory:%@ \n", [error localizedDescription]);
	}
	
	// Test if named resource exists in Documents/Data
	if (![[NSFileManager defaultManager] fileExistsAtPath:dstDb])
	{
		// Copy the named resource from bundle to Documents/Data
		if (![[NSFileManager defaultManager] copyItemAtPath:srcDb toPath:dstDb error:&error])
			NSLog(@"Error: copying resource:%@\n", [error localizedDescription]);
	}
	
	// Return full path to resource "Documents/Data/resource.type"
	return dstDb;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	// Update Current Location, if we have moved
	if (newLocation.coordinate.latitude != oldLocation.coordinate.latitude)
	{
		self.currentGPSLocation = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
		NSLog(@"Current GPS Location: %f   %f", self.currentGPSLocation.coordinate.latitude, self.currentGPSLocation.coordinate.longitude);
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
