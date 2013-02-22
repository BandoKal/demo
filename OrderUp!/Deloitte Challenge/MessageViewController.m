//
//  MessageViewController.m
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation MessageViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendButtonPressed:(id)sender
{
    // send message here
    NSString *title = self.titleTextfield.text ;
    NSString *message = self.messageTextfield.text;
    [appDelegate.manager sendMessageWithTitle:title
                                      andBody:message
                                       ofType:SMAlertMessage
                                      toPeers:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)focusOffTextField:(id)sender
{
    [(UITextField *)sender resignFirstResponder];
}
@end
