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
    // Get input data
	float h = [self.height.text floatValue];
	float indicatedAirSpeed = [self.indicatedAirSpeed.text floatValue];
	float windDirection = [self.windDirection.text floatValue];
	float windSpeed = [self.windSpeed.text floatValue];
	float track = [self.track.text floatValue];
	
	// Global Constants
	const float pi = 3.14159265;
	const float rad = pi / 180;
	const float deg = 180 / pi;
	const float T0 = 288.15;	 // Sea level standard temperature 						288.15 K
	const float TropT = 216.5; // ?
	
	// Calculate Atmospheric Pressure
	const float g  = 9.81;   // Earth-surface gravitational acceleration		9.80665 m/s2
	const float R = 287; // ??
	const float L  = 0.00198;    // Temperature lapse rate											0.0065 K/m
	const float P0 = 1013.25;    // Sea level standard atmospheric pressure		101325 Pa
	const float TropP = 226; // ?
	const float fm = 3.28126;   // Feet to meter															3.28128 feet/m
	
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
	
	NSLog(@"Atmospheric Pressure: %0.3f hPa", p);
	
	// Calculate temperature
	float t;
	
	if (h < 36090)
	{
		t = T0 - ((h / 1000) * 1.98);
	}
	else
	{
		t = TropT;
	}
	
	NSLog(@"Temperature: %0.3f K", t);
	
	// Calculate Relative Density
	// HVAD ER DET FOR ET TAL?
	float rd = (3.51823 / (p / t));
	
	NSLog(@"Relative Density: %0.3f kg/m3", rd);
	
	// Calculate True Air Speed
	float TAS = sqrtf(rd) * indicatedAirSpeed;
	
	NSLog(@"True Air Speed: %0.3f knots", TAS);
	
	// Calculate MACH
	float MACH = TAS / (38.9 * sqrtf(t));
	
	NSLog(@"MACH: %0.3f", MACH);
	
	// Calculate Heading
	float windAngle = rad * (track - windDirection);
	float windComp = sinf(windAngle) * windSpeed / TAS;
	int drift = round(deg * asinf(windComp));
	int trackInt = round(track);
	int headingInt = (360 + trackInt - drift) % 360;
	float heading = (float) headingInt;
	
	NSLog(@"Heading: %0.3f oC", heading);
	
	// Calculate Ground Speed
	float windAngle1 = rad * (heading - windDirection);
	float GS = TAS - windSpeed * cosf(windAngle1);
	
	NSLog(@"Ground Speed: %0.3f knots", GS);
	
	// Set label texts to calculated results
	self.trueAirSpeed.text = [NSString stringWithFormat:@"%.2f knots", TAS];
	self.mach.text = [NSString stringWithFormat:@"%.2f", MACH];
	self.groundSpeed.text = [NSString stringWithFormat:@"%.2f knots", GS];
}
- (IBAction)autoOnOff:(id)sender {
    if(self.autoOnOff.on)
    {
        self.height.text = @"0";
        //self.height.text = altitude;
    }else{
        self.height.text = @"";
    }
}
@end
