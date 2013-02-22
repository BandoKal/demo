//
//  SaveGroupViewController.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/16/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Member.h"
#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"

@interface SaveGroupViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UITextField *gnameTextField;
@property (weak, nonatomic) IBOutlet UITableView *memberTableView;
@property (weak, nonatomic) IBOutlet UIButton *gnameButton;
@property (nonatomic, retain) WEPopoverController *popoverController;

- (IBAction)gnameClicked:(id)sender;
- (IBAction)saveClicked:(id)sender;

@end
