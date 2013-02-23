//
//  CurrentHostViewController.m
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "CurrentHostViewController.h"

@interface CurrentHostViewController ()
{
    NSMutableArray *memberKeys;
}
@end

@implementation CurrentHostViewController
@synthesize appDelegate;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameTextView.text = self.currentOrder.orderID;
    self.locationTextView.text = self.currentOrder.orderLocation;
    self.timeTextView.text = self.currentOrder.orderTime;
    self.membersTableView.dataSource = self;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    memberKeys = [[appDelegate.manager.connectedPeers allKeys]mutableCopy];
    self.currentOrder = [appDelegate.manager.sessionOrders objectForKey:self.currentOrder.orderID];
 
    [memberKeys addObject:appDelegate.myMemberObject.memberID];
    [self.currentOrder.members addObject:appDelegate.myMemberObject];

    [self.membersTableView reloadData];
    
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
    cell.detailTextLabel.text =  [[[self.currentOrder individualOrders] objectForKey:[memberKeys objectAtIndex:indexPath.row]] orderText] ;// will display member orders
    
    return cell;
}


- (IBAction)updateButtonPressed:(id)sender {
}

- (IBAction)endButtonPressed:(id)sender {
    self.currentOrder.orderText = @"Order is Ready!";
    [appDelegate.manager sendMessageWithTitle:@"OrderUp Party Closed"
                                      andBody:self.currentOrder.orderID
                                       ofType:SMOrderUpClosed
                                      toPeers:nil];
    [appDelegate.pastOrders addObject:[[PastOrder alloc]initWithTitle:self.nameTextView.text andOrder:self.nameTextView.text]];
    [appDelegate.manager.sessionOrders removeObjectForKey:self.nameTextView.text];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"OrderUp Party closed"
                                                   message:@"Has been added to the past orders"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)placeIndividualOrder:(id)sender {

    [self performSegueWithIdentifier:@"pushPlaceOrder" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushPlaceOrder"])
    {
        PlaceOrderViewController *next = [segue destinationViewController];
        next.orderUpName  = [[NSString alloc]initWithString: self.currentOrder.orderID];
        NSLog(@"%@", self.currentOrder.orderID);
        next.orderUpLocation = [[NSString alloc]initWithString: self.currentOrder.orderLocation];
        next.currentParty = self.currentOrder;
    }
}
@end
