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
	float windAngle1 = rad * (heading - windDirection);
	float GS = TAS - windSpeed * cosf(windAngle1);
	self.trueAirSpeed.text = [NSString stringWithFormat:@"%.2f knots", TAS];
	self.mach.text = [NSString stringWithFormat:@"%.2f", MACH];
	self.groundSpeed.text = [NSString stringWithFormat:@"%.2f knots", GS];
    
}
-(void)reverseCalc
{
    //input
	float h = [self.height.text floatValue];
	float indicatedAirSpeed = [self.indicatedAirSpeed.text floatValue];
	float windDirection = [self.windDirection.text floatValue];
	float windSpeed = [self.windSpeed.text floatValue];
	float track = [self.track.text floatValue];
	//renewed input
    float GS = 3;//GPS INSERT HERE          GS
    h = 3000; //GPS INSERT HERE                  h
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
	
	
}


- (IBAction)autoOnOff:(id)sender {
    if(self.autoOnOff.on)
    {
        self.height.text = @"0";
        //self.height.text = altitudeFromGps;
        //self.groundSpeed.text = groundspeedFromGps
        self.track.enabled = NO;
        self.height.enabled = NO;
        self.windDirection.enabled = NO;
        self.windSpeed.enabled = NO;
        self.indicatedAirSpeed.enabled = NO;
        self.calculate.enabled = NO;
    }else{
        self.height.text = @"";
        self.height.enabled = YES;
        self.windSpeed.enabled = YES;
        self.windDirection.enabled = YES;
        self.indicatedAirSpeed.enabled = YES;
        self.track.enabled = YES;
        self.calculate.enabled = YES;
    }
}
@end
