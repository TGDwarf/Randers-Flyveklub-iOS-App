//
//  ThirdViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Jesper on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
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
    NSURL *url = [NSURL URLWithString:@"http://dmi.dk/fileadmin/dmiappv2t3/"];
    NSURLRequest *requesturl = [NSURLRequest requestWithURL:url];
    [WebView loadRequest:requesturl];
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
    urls = [NSArray arrayWithObjects: @"http://dmi.dk/fileadmin/dmiappv2t3/", @"http://airfields.dk/", @"http://randersflyveklub.dk/pi-cam/",nil];
    NSURL *url = [NSURL URLWithString:urls[selId]];
    NSURLRequest *requesturl = [NSURLRequest requestWithURL:url];
    WebView.scalesPageToFit = YES;
    [WebView loadRequest:requesturl];
    //http://www.dmi.dk/vejr/
    //http://www.airfields.dk/
    //http://www.randersflyveklub.dk/pi-cam/
}
@end
