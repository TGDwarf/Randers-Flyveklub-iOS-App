//
//  SettingsViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Daniel Otkjær on 4/8/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    // Do any additional setup after loading the view
    
//    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
//    {
//        const char *dbpath = [_databasePath UTF8String];
//        
//        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
//        {
//            char *errMsg;
//            const char *sql_stmt =
//            "CREATE TABLE IF NOT EXISTS AIRFIELDS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
//            NSLog(@"Created Database");
//            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
//            {
//                NSLog(@"Failed to create table");
//            }
//            sqlite3_close(_contactDB);
//        } else {
//            NSLog(@"Failed to open/create database");
//        }
//    }
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

@end
