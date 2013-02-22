//
//  AddGroupTableViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/16/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "AddGroupTableViewController.h"

@interface AddGroupTableViewController ()

@end

@implementation AddGroupTableViewController
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
    
    Member *jason = [[Member alloc] initWithName:@"Jason Bandy" andPhone:@"615-333-4444"];
    Member *chelsea = [[Member alloc] initWithName:@"Chelsea Rath" andPhone:@"615-555-8888"];
    NSArray *myGroup = [[NSArray alloc] initWithObjects:jason, chelsea, nil];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.members = [[NSArray alloc] initWithArray:myGroup];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = @"Mobile Dev Group";
    cell.detailTextLabel.text = @"Jason Bandy; Chelsea Rath;";
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
