//
//  MessageViewController.h
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MessageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *titleTextfield;
@property (strong, nonatomic) IBOutlet UITextField *messageTextfield;
- (IBAction)sendButtonPressed:(id)sender;
- (IBAction)focusOffTextField:(id)sender;

@end
