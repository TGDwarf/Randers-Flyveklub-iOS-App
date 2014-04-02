//
//  ContaktsDataViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Mads Torp on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "ContaktsDataViewController.h"

@interface ContaktsDataViewController ()
{
    NSMutableArray *tittlearray;
    NSMutableArray *sbutitlearray;
    
}
@end

@implementation ContaktsDataViewController

@synthesize mytablecview;

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
    self.mytablecview.delegate = self;
    self.mytablecview.dataSource = self;
    
    tittlearray = [[NSMutableArray alloc]initWithObjects:@"hej",@"hej2",@"hej3", nil];
    sbutitlearray =[[NSMutableArray alloc]initWithObjects:@"admin",@"torp",@"jesper", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tittlearray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellidentifier = @"Cell";
    UITableViewCell *cell   =   [tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    cell.textLabel.text = [tittlearray objectAtIndex:indexPath.row];
    
    return cell;
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
