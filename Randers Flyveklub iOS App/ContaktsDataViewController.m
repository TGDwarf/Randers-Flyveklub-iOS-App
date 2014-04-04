//
//  ContaktsDataViewController.m
//  Randers Flyveklub iOS App
//
//  Created by Mads Torp on 4/2/14.
//  Copyright (c) 2014 TGD Inc. All rights reserved.
//

#import "ContaktsDataViewController.h"
#import "DetailViewController.h"
#import "sqlite3.h"
@interface ContaktsDataViewController ()
{
    /*definere global arrays */
    NSArray *tittlearray;
    NSArray *sbutitlearray;
    NSArray *emailarray;
  
}
@end

@implementation ContaktsDataViewController
{
    NSString *db;
    sqlite3 *dbh;
    sqlite3_stmt    *stmt_query;
    NSMutableArray  *data;

}

@synthesize mytableview;

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
 
    // Copy SQlite database from App-bundle to Sandbox

    
    
    NSString *theURL = @"http://docs.google.com/spreadsheet/ccc?key=0AmByrnA8irO1dGpCVjFHbmlDUmlDNWtFMDJzcF9LR0E&output=csv";
    NSString *theFile = [NSString stringWithContentsOfURL:[NSURL URLWithString:theURL] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",theFile);
    NSArray *theCells = [theFile componentsSeparatedByString:@"\n"];
    NSLog(@"%lu",(unsigned long)[theCells count]);
    
    [super viewDidLoad];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    /*data pull til Detailviewcontroller*/
    tittlearray = [theCells[0] componentsSeparatedByString:@","];
    sbutitlearray = [theCells[2] componentsSeparatedByString:@","];
    emailarray = [theCells[1] componentsSeparatedByString:@","];
    
    
    /*Arrays der indholder vores contakt data*/
    //tittlearray = [[NSMutableArray alloc]initWithObjects:@"TGDrowf",@"Satans Nisser",@"JesperB21", nil];
    //sbutitlearray =[[NSMutableArray alloc]initWithObjects:@"Slave Pisker",@"developer",@"developer", nil];
    //emailarray = [[NSMutableArray alloc]initWithObjects:@"hulletijorden@mercantec.dk",@"maso@mercantec.dk",@"jesper@mercanteac.dk", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /*row contakt der forteller app'en antel af forvented indhold i menu'en*/
    return [tittlearray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*contakt select menu */
    static  NSString *cellidentifier = @"Cell";
    UITableViewCell *cell   =   [tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    cell.textLabel.text = [tittlearray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [sbutitlearray objectAtIndex:indexPath.row];

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailsegue"])
         {
             /*definere strings til brug*/
            NSIndexPath *indexpath = nil;
            NSString *sbutitlestring = nil;
            NSString *tittlestring = nil;
             NSString *emailstirng = nil;
             /*definere strings inholdet der skal pushes*/
             indexpath = [mytableview indexPathForSelectedRow];
             tittlestring = [tittlearray objectAtIndex:indexpath.row];
             sbutitlestring = [sbutitlearray objectAtIndex:indexpath.row];
             emailstirng = [emailarray objectAtIndex:indexpath.row];
             /*push data til detailviewcontrolleren*/
             [[segue destinationViewController]setNavncontent:tittlestring];
             [[segue destinationViewController]setRolecontent:sbutitlestring];
             [[segue destinationViewController]setEmailcontent:emailstirng];
         
         }
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
