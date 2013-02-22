//
//  CurrentHostViewController.h
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderUp.h"
#import "AppDelegate.h"
#import "PastOrder.h"

@interface CurrentHostViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *nameTextView;
@property (strong, nonatomic) IBOutlet UITextView *locationTextView;
@property (strong, nonatomic) IBOutlet UITextView *timeTextView;
@property (strong, nonatomic) OrderUp *currentOrder;
@property (strong, nonatomic) IBOutlet UITableView *membersTableView;
@property (strong,nonatomic) AppDelegate *appDelegate;
- (IBAction)updateButtonPressed:(id)sender;
- (IBAction)endButtonPressed:(id)sender;

@end
