//
//  AppDelegate.m
//  ADA_Accessibility
//
//  Created by clr4e on 12/5/12.
//  Copyright (c) 2012 MTSU Mobile Development. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize window;
@synthesize helpButtons, helpButtonValues;
@synthesize xmlArray;
@synthesize manager;
@synthesize members;
@synthesize myMemberID,myOrderID,myMemberObject;
@synthesize pastOrders;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    xmlArray = [[NSMutableArray alloc]init];
    manager = [[SessionManager alloc]init];
    manager.delegate = self;
    
    myMemberObject = [[Member alloc]init];
    myMemberObject.peerID = manager.memberSession.peerID;
    NSUUID *uid = [[UIDevice currentDevice] identifierForVendor];
    myMemberObject.memberID = uid.UUIDString;
    helpButtons = [[NSDictionary alloc] initWithObjectsAndKeys:
                   @"NO", @"orderName",
                   @"NO", @"orderLoc",
                   @"NO", @"orderTime",
                   @"NO", @"orderMembers",
                   @"NO", @"gname",
                   @"NO", @"myOrder", nil];
    helpButtonValues = [[NSMutableDictionary alloc] init];
    [helpButtonValues addEntriesFromDictionary:helpButtons];
    
    members = [[NSMutableArray alloc] init];
    pastOrders = [[NSMutableArray alloc] init];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark SessionMangerDelegate Methods

-(void)updateUIFromMessage:(NSString *)message ofType:(MessageType)messageType fromManager:(SessionManager *)manager fromMember:(Member *)member
{
    switch (messageType)
    {
        case SMInvitationMessage:
        {
            //parse message string
            NSArray *messageComponents = [message componentsSeparatedByString:@"|"];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[messageComponents objectAtIndex:0]
                                                           message:[messageComponents objectAtIndex:1]
                                                          delegate:nil
                                                 cancelButtonTitle:@"Decline"
                                                 otherButtonTitles: @"Accept",nil];
            alert.delegate = self;
            [alert show];
            break;
        }
        case SMAcceptInvitation:
        {
            // member has accepted invitation
            //parse message string
            NSArray *messageComponents = [message componentsSeparatedByString:@"|"];
            //add member to the members array
            
            NSLog(@"Member with name [%@] Accepted Invitation", [[manager.connectedPeers objectForKey:[messageComponents objectAtIndex:1]]name]);
            break;
        }
        case SMAlertMessage:
        {
            NSArray *messageComponents = [message componentsSeparatedByString:@"|"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[messageComponents objectAtIndex:0]
                                                           message:[messageComponents objectAtIndex:1]
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
            [alert show];
        }
            case SMOrderUpClosed:
        {
            [pastOrders addObject:[[PastOrder alloc]initWithTitle:message andOrder:message]];
            [manager.sessionOrders removeObjectForKey:message];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Order Has Arrived!"
                                                           message:message
                                                          delegate:nil
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
            [alert show];
        }
            
        default:
            break;
    }
}


#pragma mark UIAlertViewDelegate Methods
-(void)alertViewCancel:(UIAlertView *)alertView
{
    [manager sendMessageWithTitle:myOrderID
                          andBody:myMemberID
                           ofType:SMDeclineInvitation
                          toPeers:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    // button index != 0 is Accept
    if (buttonIndex != 0)
    {
        [manager sendMessageWithTitle:manager.currentOrderUp //orderID
                              andBody:myMemberObject.memberID // acceptingMember
                               ofType:SMAcceptInvitation
                              toPeers:nil];
        
    }
}

@end
