//
//  FourthViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Jesper on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
@end

@implementation WeatherViewController
@synthesize spdLabel;
@synthesize dirLabel;
@synthesize gustsLabel;
@synthesize pressureLabel;
@synthesize bane25Crosswind;
@synthesize bane25Headwind;
@synthesize bane7Crosswind;
@synthesize bane7Headwind;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
NSData *receivedData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:15.0 target:self
                                                selector:@selector(loadURLLink:) userInfo:nil repeats:YES];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://randersflyveklub.dk/vejr/clientraw.txt"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection)
    {
        receivedData = [NSMutableData data];
    }
}
-(void)loadURLLink:(NSTimer *)timer
{
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://randersflyveklub.dk/vejr/clientraw.txt"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection)
    {
        receivedData = [NSMutableData data];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = NULL;
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    receivedData = data;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *s = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSArray *a = [s componentsSeparatedByString:@" "];
    //NSLog();
    spdLabel.text = [NSString stringWithFormat:@"%@%@", a[1], @"Knots"];
    dirLabel.text = [NSString stringWithFormat:@"%@%@", a[3], @"Compass"];
    gustsLabel.text = [NSString stringWithFormat:@"%@%@", a[2], @"Knots"];
    pressureLabel.text = [NSString stringWithFormat:@"%@%@",a[6], @"hPa"];
    
    
    double windretning = [a[3] doubleValue];
    double windspeed = [a[1] doubleValue];
    double baneretning1 = 250;
    double baneretning2 = 70;
    double theta1 = windretning - baneretning1;
    double theta2 = windretning - baneretning2;
    double langsbane1 = windspeed * cos(theta1);
    double langsbane2 = windspeed * cos(theta2);
    double tvaersbane1 = windspeed * sin(theta1);
    double tvaersbane2 = windspeed * sin(theta2);
    
    bane7Headwind.text = [@(langsbane1) stringValue];
    bane7Crosswind.text = [@(tvaersbane1) stringValue];
    bane25Headwind.text = [@(langsbane2) stringValue];
    bane25Crosswind.text = [@(tvaersbane2) stringValue];
    
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
