//
//  PastOrdersTableViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "PastOrdersTableViewController.h"

@interface PastOrdersTableViewController ()

@end

@implementation PastOrdersTableViewController
@synthesize appDelegate;

BOOL clicked = NO;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([appDelegate.pastOrders count] > 0)
        return [appDelegate.pastOrders count];
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if ([appDelegate.pastOrders count] > 0)
    {
        cell.textLabel.text = [[appDelegate.pastOrders objectAtIndex:indexPath.row] pastTitle];
        cell.detailTextLabel.text = [[appDelegate.pastOrders objectAtIndex:indexPath.row] pastOrder];
    
        if (clicked)
        {
            cell.detailTextLabel.numberOfLines = 4;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        }
        else
        {
            cell.detailTextLabel.numberOfLines = 1;
            cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        }
    }
    else
    {
        cell.textLabel.text = @"No past orders to display";
    }
    
    return cell;
}

// asks the delegate for the ehight to use for a row in a specified location
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (clicked)
        return 75;
    else
        return 45;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!clicked)
        clicked = YES;
    else
        clicked = NO;
}

@end
