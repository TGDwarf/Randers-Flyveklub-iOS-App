//
//  ThirdViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Jesper on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize WebView;
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

- (IBAction)bookmarks:(id)sender {
    UISegmentedControl *segControl = (UISegmentedControl *)sender;
    NSInteger selId;
    selId = [segControl selectedSegmentIndex];
    NSArray *urls;
    urls = [NSArray arrayWithObjects: @"http://dmi.dk/vejr/", @"http://airfields.dk/", @"http://randersflyveklub.dk/pi-cam/",nil];
    NSURL *url = [NSURL URLWithString:urls[selId]];
    NSURLRequest *requesturl = [NSURLRequest requestWithURL:url];
    [WebView loadRequest:requesturl];
    //http://www.dmi.dk/vejr/
    //http://www.airfields.dk/
    //http://www.randersflyveklub.dk/pi-cam/
}
@end
