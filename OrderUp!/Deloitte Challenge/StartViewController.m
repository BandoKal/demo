//
//  StartViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/3/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()
{
    OrderUp *currentOrder;
}

@end

@implementation StartViewController
@synthesize appDelegate;
@synthesize orderName, orderNameHelp;
@synthesize orderLoc, orderLocHelp;
@synthesize orderTime, orderTimeHelp;
@synthesize memberTable;
@synthesize orderMemberHelp;
@synthesize popoverController;
@synthesize datePicker;

CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

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
    
    // set up the date picker
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    [self.datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    self.orderTime.inputView = self.datePicker;
    
    // set text field delegate
    orderName.delegate = self;
    orderLoc.delegate = self;
    orderTime.delegate = self;
    
    // set table view delegate and datasource
    memberTable.delegate = self;
    memberTable.dataSource = self;
    [memberTable reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [memberTable reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.popoverController dismissPopoverAnimated:NO];
    self.popoverController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// called when the date is changed on the date picker
- (void)dateChanged
{
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    self.orderTime.text = [dateFormat stringFromDate:date];
}

// called when the text field begins editing
- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    [self animateTextField:textField up:YES];
}

// called when the text field is finished editing
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

// exits the textfield when return is pressed on the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// exits the textfield when clicked outside of it
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.orderName resignFirstResponder];
    [self.orderLoc resignFirstResponder];
    [self.orderTime resignFirstResponder];
}

// animates the text field either up or down to avoid getting covered by the keyboard
- (void)animateTextField:(UITextField *)textField up:(BOOL)up
{
    int animatedDistance;
    int moveUpValue = textField.frame.origin.y + (textField.frame.size.height * 3);
    
    animatedDistance = PORTRAIT_KEYBOARD_HEIGHT - (460-moveUpValue-5);
    
    if (animatedDistance > 0)
    {
        const int movementDistance = animatedDistance;
        const float movementDuration = 0.3f;
        int movement = (up ? -movementDistance : movementDistance);
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}

// defines what will happen when the Order Name Help icon is clicked
- (IBAction)orderNameHelpClicked:(id)sender
{
    // exits textField editing
    [self.orderName resignFirstResponder];
    [self.orderLoc resignFirstResponder];
    [self.orderTime resignFirstResponder];
    
    // change bool value in appdelegate array
    [appDelegate.helpButtonValues setValue:@"YES" forKey:@"orderName"];
    
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
        [self.popoverController presentPopoverFromRect:orderNameHelp.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
}

// defines what will happen when the Order Location Help icon is clicked
- (IBAction)orderLocHelpClicked:(id)sender
{
    // exits textField editing
    [self.orderName resignFirstResponder];
    [self.orderLoc resignFirstResponder];
    [self.orderTime resignFirstResponder];
    
    // change bool value in appdelegate array
    [appDelegate.helpButtonValues setValue:@"YES" forKey:@"orderLoc"];
    
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
        [self.popoverController presentPopoverFromRect:orderLocHelp.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
}

// defines what will happen when the Order Time Help icon is clicked
- (IBAction)orderTimeHelpClicked:(id)sender
{
    // exits textField editing
    [self.orderName resignFirstResponder];
    [self.orderLoc resignFirstResponder];
    [self.orderTime resignFirstResponder];
    
    // change bool value in appdelegate array
    [appDelegate.helpButtonValues setValue:@"YES" forKey:@"orderTime"];
    
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
        [self.popoverController presentPopoverFromRect:orderTimeHelp.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
}

- (IBAction)orderMemberHelpClicked:(id)sender
{
    // exits textField editing
    [self.orderName resignFirstResponder];
    [self.orderLoc resignFirstResponder];
    [self.orderTime resignFirstResponder];
    
    // change bool value in appdelegate array
    [appDelegate.helpButtonValues setValue:@"YES" forKey:@"orderMembers"];
    
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
        [self.popoverController presentPopoverFromRect:orderMemberHelp.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }
}

- (IBAction)addMember:(id)sender
{
    // display the address book picker
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:NO completion:nil];
}

- (IBAction)doneClicked:(id)sender {
    NSString *message = [NSString stringWithFormat:@"Name: %@\nLocation: %@\nTime: %@", orderName.text, orderLoc.text, orderTime.text];
    [appDelegate.manager sendInvitationsWithTitle:@"You're Invited" andMessage:message ToPeers:nil];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Order Up Created" message:@"Your order has been created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    
    /*
     appDelegate.orderID = SAVE ORDER ID HERE
     */
    appDelegate.myOrderID = orderName.text;
    currentOrder = [[OrderUp alloc]init];
    currentOrder.orderID = orderName.text;
    currentOrder.orderLocation = orderLoc.text;
    currentOrder.orderTime = orderTime.text;
    if (![appDelegate.manager.sessionOrders objectForKey:orderName.text])
    {
        [appDelegate.manager.sessionOrders setObject:currentOrder forKey:orderName.text];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - TableView Delegate

// tells the delegate that the specified row is now selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // do nothing...
}

// tells the delegate that the specified row is now unselected
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableView Data Source

// asks the data source for a cell to insert in a particular location of the table view (required)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"memberCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    cell.textLabel.text = [[appDelegate.members objectAtIndex:indexPath.row] name];
    cell.detailTextLabel.text = [[appDelegate.members objectAtIndex:indexPath.row] phone];
    
    return cell;
}

// asks the data source to return the number of sections in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// tells the data source to return the number of rows in a given section of a table view (required)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appDelegate.members count];
}

// asks the data source to return the titles for the sections for a table view
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // used for index list
    return nil;
}

// asks the data source for the title of the header of teh specified section of the table view
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - ABPEoplePickerNavigationControllerDelegate Methods

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSString *fname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString *lname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    //NSString *number = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonPhoneProperty));
    NSString *number = @"None";
    Member *mem = [[Member alloc] initWithName:[NSString stringWithFormat:@"%@ %@", fname, lname] andPhone:number];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

@end
