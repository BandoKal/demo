//
// WEPopoverContentViewController.m
// WEPopover
//
// Created by Werner Altewischer on 06/11/10.
// Copyright 2010 Werner IT Consultancy. All rights reserved.
//
// Edited by Chelsea Rath on 02/04/2013

#import "WEPopoverContentViewController.h"


@implementation WEPopoverContentViewController
@synthesize appDelegate;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
        //self.contentSizeForViewInPopover = CGSizeMake(100, 1 * 44 - 1);
        self.contentSizeForViewInPopover = CGSizeMake(self.view.frame.size.width - 100, self.view.frame.size.height / 5);
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = (self.view.frame.size.height / 5) + 5;
    self.view.backgroundColor = [UIColor clearColor];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    if ([[appDelegate.helpButtonValues objectForKey:@"orderName"] isEqualToString:@"YES"])
    {
        // order name help button
        cell.textLabel.text = [NSString stringWithFormat:@"The order name will be displayed to all invited members."];
        [appDelegate.helpButtonValues setValue:@"NO" forKey:@"orderName"];
    }
    else if ([[appDelegate.helpButtonValues objectForKey:@"orderLoc"] isEqualToString:@"YES"])
    {
        // order name help button
        cell.textLabel.text = [NSString stringWithFormat:@"The location where the order will be placed to."];
        [appDelegate.helpButtonValues setValue:@"NO" forKey:@"orderLoc"];
    }
    else if ([[appDelegate.helpButtonValues objectForKey:@"orderTime"] isEqualToString:@"YES"])
    {
        // order name help button
        cell.textLabel.text = [NSString stringWithFormat:@"The time the order will be placed."];
        [appDelegate.helpButtonValues setValue:@"NO" forKey:@"orderTime"];
    }
    else if ([[appDelegate.helpButtonValues objectForKey:@"orderMembers"] isEqualToString:@"YES"])
    {
        // order name help button
        cell.textLabel.text = [NSString stringWithFormat:@"The members to invite to this order run."];
        [appDelegate.helpButtonValues setValue:@"NO" forKey:@"orderMembers"];
    }
    else if ([[appDelegate.helpButtonValues objectForKey:@"gname"] isEqualToString:@"YES"])
    {
        // order name help button
        cell.textLabel.text = [NSString stringWithFormat:@"Name that will be associated with the group members."];
        [appDelegate.helpButtonValues setValue:@"NO" forKey:@"gname"];
    }
    else if ([[appDelegate.helpButtonValues objectForKey:@"myOrder"] isEqualToString:@"YES"])
    {
        // order name help button
        cell.textLabel.text = [NSString stringWithFormat:@"The order you wish to place at the location specified."];
        [appDelegate.helpButtonValues setValue:@"NO" forKey:@"myOrder"];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end

