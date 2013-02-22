//
//  SaveGroupViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/16/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "SaveGroupViewController.h"

@interface SaveGroupViewController ()

@end

@implementation SaveGroupViewController
@synthesize appDelegate;
@synthesize gnameButton,gnameTextField,memberTableView;
@synthesize popoverController;

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

    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    memberTableView.delegate = self;
    memberTableView.dataSource = self;
    
    if ([appDelegate.members count] > 0)
    {
        gnameTextField.text = @"Mobile Dev Group";
        [gnameTextField setEnabled:NO];
    }
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
    NSLog(@"%i", [appDelegate.members count]);
    return [appDelegate.members count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSLog(@"%@", [[appDelegate.members objectAtIndex:indexPath.row]name]);
    cell.textLabel.text = [[appDelegate.members objectAtIndex:indexPath.row] name];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // do nothing...
}

- (IBAction)gnameClicked:(id)sender {

    // exits textField editing
    [self.gnameTextField resignFirstResponder];
    
    // change bool value in appdelegate array
    [appDelegate.helpButtonValues setValue:@"YES" forKey:@"gname"];
    
    // create popover
    if (self.popoverController)
    {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
    else
    {
        UIViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        
        self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
        [self.popoverController presentPopoverFromRect:gnameButton.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
}

- (IBAction)saveClicked:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Group Saved" message:@"Your group has been saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
