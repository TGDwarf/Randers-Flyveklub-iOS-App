//
//  FourthViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Jesper on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
{
//    NSMutableArray *data;
}
@end

@implementation WeatherViewController

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
    //NSData *receivedData;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://randersflyveklub.dk/vejr/clientraw.txt"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection)
    {
        receivedData = [NSMutableData data];
    }
    // Do any additional setup after loading the view.
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
    NSLog(a[0]);
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
