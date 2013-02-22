//
//  AppDelegate.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 1/28/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionManager.h"
#import "Member.h"
#import "PastOrder.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, SessionManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *helpButtons;
@property (strong, nonatomic) NSMutableDictionary *helpButtonValues;
@property (strong, nonatomic) NSMutableArray *xmlArray;
@property (strong, nonatomic) SessionManager *manager;
@property (strong, nonatomic) Member *myMemberObject;
@property (strong, nonatomic) NSMutableArray *members;
@property (strong, nonatomic) NSString *myOrderID,*myMemberID;
@property (strong, nonatomic) NSMutableArray *pastOrders;

@end