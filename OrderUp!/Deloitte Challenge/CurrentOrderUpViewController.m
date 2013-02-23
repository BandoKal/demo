//
//  CurrentOrderUpViewController.m
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "CurrentOrderUpViewController.h"

@interface CurrentOrderUpViewController ()
{
    NSMutableArray *memberKeys;
}

@end

@implementation CurrentOrderUpViewController
@synthesize appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.nameTextView.text = self.currentOrder.orderID;
    self.locationTextView.text = self.currentOrder.orderLocation;
    self.timeTextView.text = self.currentOrder.orderTime;
    self.membersTableView.dataSource = self;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    memberKeys = [[appDelegate.manager.connectedPeers allKeys]mutableCopy];
    NSLog(@"memberID = %@", appDelegate.myMemberObject.memberID);
    [memberKeys addObject:appDelegate.myMemberObject.memberID];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.membersTableView reloadData];
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
    return [self.currentOrder.members count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"memberCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[appDelegate.manager.connectedPeers objectForKey:[memberKeys objectAtIndex:indexPath.row]]name];
    cell.detailTextLabel.text =  [[[self.currentOrder individualOrders] objectForKey:[memberKeys objectAtIndex:indexPath.row]] orderText] ;// will display members orders
    return cell;
}


- (IBAction)notifyPlacedOrder:(id)sender {
    // send notification message to users - not wanting to work correctly???
//    [appDelegate.manager sendMessageWithTitle:@"Order Placed" andBody:@"One of your orders has been placed" ofType:SMAlertMessage toPeers:nil];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification Sent" message:@"You have successfully notified all members the order has been placed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)notifyArrivedOrder:(id)sender {
    // send notification message to users - also not wanting to work correctly???
//    [appDelegate.manager sendMessageWithTitle:@"Order Arrived" andBody:@"One of your orders has arrived" ofType:SMAlertMessage toPeers:nil];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification Sent" message:@"You have successfully notified all members the order has arrived." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)placeIndividualOrder:(id)sender {
    [self performSegueWithIdentifier:@"pushPlaceOrder" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushPlaceOrder"])
    {
        PlaceOrderViewController *next = [segue destinationViewController];
        next.orderUpName  = self.currentOrder.orderID;
        NSLog(@"%@", self.currentOrder.orderID);
        next.orderUpLocation = self.currentOrder.orderLocation;
        next.currentParty = self.currentOrder;
    }
}


@end
