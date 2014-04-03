//
//  FourthViewController.h
//  Randers Flyveklub iOS App
//
//  Created by Jesper on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *spdLabel;
@property (weak, nonatomic) IBOutlet UILabel *dirLabel;
@property (weak, nonatomic) IBOutlet UILabel *gustsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *bane7Headwind;
@property (weak, nonatomic) IBOutlet UILabel *bane7Crosswind;
@property (weak, nonatomic) IBOutlet UILabel *bane25Headwind;
@property (weak, nonatomic) IBOutlet UILabel *bane25Crosswind;

@end
