//
//  ContaktsDataViewController.h
//  Randers Flyveklub iOS App
//
//  Created by Mads Torp on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface ContaktsDataViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    sqlite3 *contakt;
}


@property (weak, nonatomic) IBOutlet UITableView *mytableview;

@end
