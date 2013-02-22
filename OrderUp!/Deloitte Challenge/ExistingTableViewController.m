//
//  ExistingTableViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/16/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "ExistingTableViewController.h"

@interface ExistingTableViewController ()
{
    NSArray *orderUps;
    NSIndexPath *selectedPath;
}

@end

@implementation ExistingTableViewController
@synthesize appDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    orderUps = [[NSArray alloc]initWithArray:[appDelegate.manager.sessionOrders allKeys]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [appDelegate.manager.sessionOrders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [orderUps objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedPath = indexPath;
    if (appDelegate.manager.isHost)
    {
        [self performSegueWithIdentifier:@"pushHost" sender:self];
    }
    else
        [self performSegueWithIdentifier:@"viewOrderUp" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"viewOrderUp"])
    {
        CurrentOrderUpViewController *next = [segue destinationViewController];
        next.currentOrder = [appDelegate.manager.sessionOrders objectForKey:[orderUps objectAtIndex:selectedPath.row]];
    }
    else if ([segue.identifier isEqualToString:@"pushHost"])
    {
        CurrentHostViewController *next= [segue destinationViewController];
        next.currentOrder = [appDelegate.manager.sessionOrders objectForKey:[orderUps objectAtIndex:selectedPath.row]];
    }
}
@end
