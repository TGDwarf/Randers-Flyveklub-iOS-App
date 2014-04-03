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

@end
