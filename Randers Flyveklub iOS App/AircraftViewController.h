//
//  FifthViewController.h
//  Randers Flyveklub iOS App
//
//  Created by Jesper on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface AircraftViewController : UIViewController
- (IBAction)calculate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *calculate;
@property (weak, nonatomic) IBOutlet UILabel *groundSpeed;
@property (weak, nonatomic) IBOutlet UILabel *mach;
@property (weak, nonatomic) IBOutlet UILabel *trueAirSpeed;
@property (weak, nonatomic) IBOutlet UITextField *track;
@property (weak, nonatomic) IBOutlet UITextField *windSpeed;
@property (weak, nonatomic) IBOutlet UITextField *windDirection;
@property (weak, nonatomic) IBOutlet UITextField *indicatedAirSpeed;
@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UISwitch *autoOnOff;
- (IBAction)autoOnOff:(id)sender;

@property (nonatomic) double altitudeFromGps;
@property (nonatomic) double groundspeedFromGps;

@end
