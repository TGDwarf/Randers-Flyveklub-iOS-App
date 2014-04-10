//
//  DetailViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Mads Torp on 4/3/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()


@end

@implementation DetailViewController
@synthesize navn, role, title ,emailmessege;
@synthesize navncontent, rolecontent, emailcontent, picturelinkdata;
@synthesize navbar, kontaktpic;
@synthesize image;


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
   
    
    
    /*setting string*/
    self.navn.text = self.navncontent;
    self.role.text = self.rolecontent;
    self.email.text = self.emailcontent;
    
    
    /*download af contakt picture fra nsdata image */
   
    kontaktpic.image = (UIImage *)image;
    
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


- (IBAction)button:(id)sender {
    
    
    // Email Subject
    NSString *emailTitle = [NSString stringWithFormat:@"%@ test mail", self.rolecontent ];
    // Email Content
    NSString *messageBody = @"iOS programming is so fun!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:self.emailcontent];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    
    if ([MFMailComposeViewController canSendMail]) {
    
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    }
    
}
    
    - (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
    {
        switch (result)
        {
            case MFMailComposeResultCancelled:
                NSLog(@"Mail cancelled");
                break;
            case MFMailComposeResultSaved:
                NSLog(@"Mail saved");
                break;
            case MFMailComposeResultSent:
                NSLog(@"Mail sent");
                break;
            case MFMailComposeResultFailed:
                NSLog(@"Mail sent failure: %@", [error localizedDescription]);
                break;
            default:
                break;
        }
        
        // Close the Mail Interface
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    

@end
