//
//  SecondViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Daniel Otkjær on 4/1/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "SecondViewController.h"
#import "ContaktViewController.h"


@interface SecondViewController ()
@property (strong, nonatomic) IBOutletCollection(UITableView) NSArray *contakt;
@end
@implementation SecondViewController

@synthesize tableData;



- (void)viewDidLoad
{
tableData = [[NSArray alloc] initWithObjects:@"TG Drowf",@"Satans NIsser",@"JesperB21",@"", nil];

[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Mycell"];
            
            if (cell == nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell" ];
    
    
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
    

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id){

}

@end
