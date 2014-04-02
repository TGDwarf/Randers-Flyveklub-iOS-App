//
//  SecondViewController.h
//  Randers Flyveklub iOS App
//
//  Created by Daniel Otkjær on 4/1/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *tableData;
}
@property (nonatomic, retain) NSArray *tableData;
@property (weak, nonatomic) IBOutlet UITableView *mycell;

@end
