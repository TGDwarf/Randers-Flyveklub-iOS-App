//
//  FifthViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Jesper on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "AircraftViewController.h"

@interface AircraftViewController ()

@end

@implementation AircraftViewController
{
    GMSMapView *mapView_;
    
    GMSOrientation orientation;
    
    CLLocation *locationFromGMaps;
}

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];

    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
   [mapView_ addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"] && self.autoOnOff.on) {
            locationFromGMaps = [object myLocation];
        //...
        _altitudeFromGps = locationFromGMaps.altitude;
        _groundspeedFromGps = locationFromGMaps.speed;
        _headingFromGMaps = orientation.heading;
        _pitchFromGMaps = orientation.pitch;
        self.height.text = [NSString stringWithFormat:@"%f", _altitudeFromGps];
        self.groundSpeed.text = [NSString stringWithFormat:@"%f", _groundspeedFromGps];
        self.heading.text = [NSString stringWithFormat:@"%f", _headingFromGMaps];
        NSLog(@"User's location: %@", locationFromGMaps);
        NSLog(@"User's altitude: %f", locationFromGMaps.altitude);
        NSLog(@"User's speed: %f", locationFromGMaps.speed);

        
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

- (IBAction)calculate:(id)sender {
    //self.track.enabled = NO;
    //self.track.enabled = YES;
    [self.track resignFirstResponder];
    [self.height resignFirstResponder];
    [self.indicatedAirSpeed resignFirstResponder];
    [self.windSpeed resignFirstResponder];
    [self.windDirection resignFirstResponder];
    
    //input
	float h = [self.height.text floatValue];
    float indicatedAirSpeed = [self.indicatedAirSpeed.text floatValue];
	float windDirection = [self.windDirection.text floatValue];
	float windSpeed = [self.windSpeed.text floatValue];
	float track = [self.track.text floatValue];
	// Global Constants
	const float pi = M_PI;
	const float rad = pi / 180; //degrees to rads ratio (degrees * this_value = rad)
	const float deg = 180 / pi; //rads to degrees ratio (rads * this_value = degrees)
	const float T0 = 288.15;	 // Sea level standard temperature 						288.15 K
	const float TropT = 216.5;
	// Calculate Atmospheric Pressure
	const float g  = 9.81;   //gravity
	const float R = 287;
	const float L  = 0.00198;    // "temperature lapse rate"
	const float P0 = 1013.25;    // Sea level standard atmospheric pressure		101325 Pa
	const float TropP = 226;
	const float fm = 3.28126;   // feet/meter ratio
	
	float p;
	
	if (h < 36090)
	{
		float pow1 = (1 - (L * h / T0));
		float pow2 = (g / (R * L * fm));
		p = powf(pow1, pow2);
		p = P0 * p;
	}
	else
	{
		p = TropP * exp(-g * ((h - 36090) / fm) / (R * TropT));
	}
	float t;
	
	if (h < 36090)
	{
		t = T0 - ((h / 1000) * 1.98);
	}
	else
	{
		t = TropT;
	}
	float rd = (3.51823 / (p / t));
	float TAS = sqrtf(rd) * indicatedAirSpeed;
	float MACH = TAS / (38.9 * sqrtf(t));
	float windAngle = rad * (track - windDirection);
	float windComp = sinf(windAngle) * windSpeed / TAS;
	int drift = round(deg * asinf(windComp));
	int trackInt = round(track);
	float heading = (float) ((360 + trackInt - drift) % 360);
    if(self.autoOnOff.on){
        heading = [self.heading.text floatValue];
    }
	float windAngle1 = rad * (heading - windDirection);
	float GS = TAS - windSpeed * cosf(windAngle1);
	self.trueAirSpeed.text = [NSString stringWithFormat:@"%.2f knots", TAS];
	self.mach.text = [NSString stringWithFormat:@"%.2f", MACH];
    if(self.autoOnOff.on){
        GS = [[[self.groundSpeed.text componentsSeparatedByString:@" knots"] objectAtIndex:0] floatValue];
        self.groundSpeed.text = [NSString stringWithFormat:@"%.2f knots", GS];
    }else{
        self.groundSpeed.text = [NSString stringWithFormat:@"%.2f knots", GS];
    }
}

- (IBAction)autoOnOff:(id)sender {
    if(self.autoOnOff.on)
    {
        self.height.text = @"0";
        self.height.enabled = NO;
        self.headingLabel.text = @"Heading (GPS)";
        self.altitudeLabel.text = @"Altitude (GPS)";
        self.groundSpeedLabel.text = @"Ground Speed (GPS)";
    }else{
        self.height.text = @"";
        self.height.enabled = YES;
        self.headingLabel.text = @"Heading";
        self.altitudeLabel.text = @"Altitude";
        self.groundSpeedLabel.text = @"Ground Speed";
    }
}
@end
