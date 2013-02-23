//
//  PlaceOrderViewController.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"
#import "Order.h"
#import "OrderUp.h"

@interface PlaceOrderViewController : UIViewController

@property (strong, nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UIButton *myOrderHelp;
- (IBAction)myOrderHelpClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *orderTextField;
- (IBAction)addOrder:(id)sender;

@property (nonatomic, retain) WEPopoverController *popoverController;
@property (strong, nonatomic) IBOutlet UILabel *orderUpNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderUpLocationLabel;
@property (strong, nonatomic) NSString *orderUpName, *orderUpLocation;
@property (strong, nonatomic) OrderUp *currentParty;



@end
