//
//  ContaktsDataViewController.h
//  Randers Flyveklub iOS App
//
//  Created by Mads Torp on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContaktsDataViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytablecview;
@property (weak, nonatomic) IBOutlet UITableView *mytableview;

@end
