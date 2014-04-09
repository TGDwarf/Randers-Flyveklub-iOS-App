//
//  ContaktsDataViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Mads Torp on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "ContaktsDataViewController.h"
#import "DetailViewController.h"
#import "sqlite3.h"
@interface ContaktsDataViewController ()
{
    /*definere global arrays */
    NSArray *tittlearray;
    NSArray *sbutitlearray;
    NSArray *emailarray;
    NSArray *picturelink;
  
}
@end

@implementation ContaktsDataViewController
{
    NSString *db;
    sqlite3 *dbh;
    sqlite3_stmt    *stmt_query;
    NSMutableArray  *data;

}

@synthesize mytableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
 


    
    /*download af content af google spreadsheet*/
    NSString *theURL = @"http://docs.google.com/spreadsheet/ccc?key=0AmByrnA8irO1dGpCVjFHbmlDUmlDNWtFMDJzcF9LR0E&output=csv";
    NSString *theFile = [NSString stringWithContentsOfURL:[NSURL URLWithString:theURL] encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",theFile);
    NSArray *theCells = [theFile componentsSeparatedByString:@"\n"];
    //NSLog(@"%lu",(unsigned long)[theCells count]);
    
    
    
    [super viewDidLoad];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    /*data pull til Detailviewcontroller*/
    tittlearray = [theCells[0] componentsSeparatedByString:@","];
    sbutitlearray = [theCells[2] componentsSeparatedByString:@","];
    emailarray = [theCells[1] componentsSeparatedByString:@","];
   picturelink = [theCells[3] componentsSeparatedByString:@","];
    
    
    /*Arrays der indholder vores contakt data*/
    //tittlearray = [[NSMutableArray alloc]initWithObjects:@"TGDrowf",@"Satans Nisser",@"JesperB21", nil];
    //sbutitlearray =[[NSMutableArray alloc]initWithObjects:@"Slave Pisker",@"developer",@"developer", nil];
    //emailarray = [[NSMutableArray alloc]initWithObjects:@"hulletijorden@mercantec.dk",@"maso@mercantec.dk",@"jesper@mercanteac.dk", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /*row contakt der forteller app'en antel af forvented indhold i menu'en*/
    return [tittlearray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*contakt select menu */
    static  NSString *cellidentifier = @"Cell";
    UITableViewCell *cell   =   [tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    cell.textLabel.text = [tittlearray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [sbutitlearray objectAtIndex:indexPath.row];

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailsegue"])
         {
             /*definere strings til brug*/
             NSIndexPath *indexpath = nil;
             NSString *sbutitlestring = nil;
             NSString *tittlestring = nil;
             NSString *emailstirng = nil;
             NSString *picturestring = nil;
             /*definere strings inholdet der skal pushes*/
             indexpath = [mytableview indexPathForSelectedRow];
             tittlestring = [tittlearray objectAtIndex:indexpath.row];
             sbutitlestring = [sbutitlearray objectAtIndex:indexpath.row];
             emailstirng = [emailarray objectAtIndex:indexpath.row];
             picturestring = [picturelink objectAtIndex:indexpath.row];
             /*push data til detailviewcontrolleren*/
             [[segue destinationViewController]setPicturelinkdata:picturestring];
             [[segue destinationViewController]setNavncontent:tittlestring];
             [[segue destinationViewController]setRolecontent:sbutitlestring];
             [[segue destinationViewController]setEmailcontent:emailstirng];
         
         }
}



/*database import*/
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
