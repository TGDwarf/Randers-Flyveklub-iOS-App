//
//  MapViewController.h
//  Randers Flyveklub iOS App
//
//  Created by Daniel Otkjær on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<GMSMapViewDelegate, CLLocationManagerDelegate, NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *showAirfields;
@property (nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentGPSLocation;

@end
