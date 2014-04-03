//
//  DetailViewController.h
//  Randers Flyveklub iOS App
//
//  Created by Mads Torp on 4/3/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (weak, nonatomic) IBOutlet UILabel *navn;
@property (weak, nonatomic) IBOutlet UILabel *role;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) NSString *navncontent;
@property (strong, nonatomic) NSString *rolecontent;
@property (strong, nonatomic) NSString *emailcontent;
@property (weak, nonatomic) IBOutlet UIButton *contakt;


@end
