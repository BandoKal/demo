//
//  SessionManager.m
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager
@synthesize delegate;
@synthesize connectedPeers, availablePeers, sessionOrders,pastOrders;
@synthesize memberSession,currentOrderUp;


/************************* Controller available methods *************************/

-(id)init
{
    if (self = [super init])
    {
        availablePeers = [[NSMutableDictionary alloc]init];
        connectedPeers = [[NSMutableDictionary alloc]init];
        sessionOrders = [[NSMutableDictionary alloc]init];
        pastOrders = [[NSMutableDictionary alloc]init];
        for (int i = 0; i<3; i++)
        {
            Member *billyMember = [[Member alloc]init];
            switch (i) {
                case 0:
                {
                    billyMember.memberID = @"3B7E6404-7DCE-43EB-A4E6-7DE8D18D1A66";
                    billyMember.name = @"Matt Smith";
                    billyMember.phone = @"6159999999";
                    break;
                }
                case 1:
                {
                    billyMember.memberID = @"6701416E-EEB8-4A8A-B168-E329DC68A88E";
                    billyMember.name = @"David Tennant";
                    billyMember.phone = @"6159999999";
                    break;
                }
                case 2:
                {
                    billyMember.memberID = @"563E3113-CF33-46BF-9DA2-FFE89CDF4245";
                    billyMember.name = @"Billie Piper";
                    billyMember.phone = @"6159999999";
                    break;
                }
                    
                    
                default:
                    break;
            }
            [self.connectedPeers setObject:billyMember forKey:billyMember.memberID];
        }
        self.isHost = NO;
        [self beginSession];
    }
    return self;
}

-(void)sendInvitationsWithTitle: (NSString*) title andMessage: (NSString*)message ToPeers: (NSArray*)peers
{
    //send invitations to peers
    self.isHost = YES;
    // build message string
    NSString *appendedMessage = [NSString stringWithFormat:@"0%@|%@",title,message];
    //package string as NSData object
    NSData *textData = [appendedMessage dataUsingEncoding:NSASCIIStringEncoding];
    if (peers == nil)
        [memberSession sendDataToAllPeers:textData
                             withDataMode:GKSendDataReliable
                                    error:nil];
    else
        [memberSession sendData:textData
                        toPeers:peers
                   withDataMode:GKSendDataReliable
                          error:nil];

    
//    NSLog(@"Invite Sent");
    
}

-(void)sendMessageWithTitle:(NSString*) title andBody: (NSString*) body ofType: (MessageType)messageType toPeers:(NSArray *)peerIDs
{
    NSData *textData;
  
    if (messageType > SMAcceptInvitation)
    {
        // build order string
        NSString *appendedMessage = [NSString stringWithFormat:@"%d%@" , messageType, body];
        //package string as NSData object
        textData = [appendedMessage dataUsingEncoding:NSASCIIStringEncoding];
    }
    else if (messageType == SMAcceptInvitation)
    {
        // build message string
        NSString *appendedMessage = [NSString stringWithFormat:@"%d%@|%@|%@", messageType, title, body ,[memberSession peerID]];
        //package string as NSData object
        textData = [appendedMessage dataUsingEncoding:NSASCIIStringEncoding];
    }
    else if(messageType == SMOrderUpClosed)
    {
        NSString *appendedMessage = [NSString stringWithFormat:@"%d%@", messageType,body];
        //package string as NSData object
        textData = [appendedMessage dataUsingEncoding:NSASCIIStringEncoding];
    }
    else
    {
        // build message string
        NSString *appendedMessage = [NSString stringWithFormat:@"%d%@|%@", messageType, title, body];
        NSLog(@"[%@] [%@]", title, body);
        //package string as NSData object
        textData = [appendedMessage dataUsingEncoding:NSASCIIStringEncoding];
    }
    if (peerIDs == nil)
    {
        //send data to all connected peers
        [memberSession sendDataToAllPeers:textData withDataMode:GKSendDataReliable error:nil];
    }
    else
    {
        //send data to specified peers
        [memberSession sendData:textData
                        toPeers:peerIDs
                   withDataMode:GKSendDataReliable
                          error:nil];
    }
    
}


-(void)invitationDeclinedByMember: (Member*) member
{
//    [self sendMessageWithTitle:nil
//                       andBody:member.peerID
//                        ofType:SMDeclineInvitation
//                       toPeers:[connectedPeers allKeys]];
    if ([connectedPeers objectForKey:member.peerID] != nil)
    {
        [memberSession disconnectPeerFromAllPeers:member.peerID]; // disconnect from peer
        [connectedPeers removeObjectForKey:member.peerID]; //remove the member from connected
    }
}
-(void)inivitationAcceptedByMember: (Member*) member
{
//    [self sendMessageWithTitle:nil
//                       andBody:member.peerID
//                        ofType:SMAcceptInvitation
//                       toPeers:[connectedPeers allKeys]];
    if (![connectedPeers objectForKey:member.peerID])
    {
        [memberSession connectToPeer:member.peerID
                         withTimeout:40.0];
        [connectedPeers setObject:member forKey:member.peerID];
    }

    
//    [NSTimer scheduledTimerWithTimeInterval:15.0
//                                     target:self
//                                   selector:@selector(sendTest)
//                                   userInfo:nil
//                                    repeats:NO];
}


/****************************** Internal methods *********************************/

//-(void)sendTest
//{
//    [self sendInvitationsWithMessage:@"StarBucks WHOA!!! Yeah caffine!"
//                             ToPeers:[connectedPeers allValues]];
//}

-(void) beginSession
{
    memberSession = [[GKSession alloc]initWithSessionID:SESSION_ID
                                            displayName:nil
                                            sessionMode:GKSessionModePeer];
    memberSession.available = YES;
    memberSession.delegate = self;
    [memberSession setDataReceiveHandler:self
                             withContext:nil];
}

-(void)endSession
{
    memberSession.available = NO;
    memberSession = nil;
}

-(void)receiveData:(NSData *)data
          fromPeer:(NSString *)peer
         inSession:(GKSession *)session
           context:(void *)contex
{

    //unpackage NSData to NSString and set incoming text as label's text
    NSString *receivedString = [[NSString alloc] initWithData:data
                                                     encoding:NSASCIIStringEncoding];
    NSString *componentString = [receivedString substringToIndex:1];
    NSString *messageString = [receivedString substringFromIndex:1];
    NSInteger choice = [componentString intValue];
    
    
    switch (choice) {
        case SMInvitationMessage:
        {
            NSArray *components = [messageString componentsSeparatedByString:@"|"];
            NSArray *orderComponents = [[components objectAtIndex:1]componentsSeparatedByString:@"\n"];
            OrderUp *newOrder = [[OrderUp alloc]init];
            newOrder.orderID = [[orderComponents objectAtIndex:0] stringByReplacingOccurrencesOfString:@"Name: " withString:@""];
//            NSLog(@"------- %@ --------", [[orderComponents objectAtIndex:1]stringByReplacingOccurrencesOfString:@"Location: " withString:@""]);
            newOrder.orderLocation = [[orderComponents objectAtIndex:1]stringByReplacingOccurrencesOfString:@"Location: " withString:@""];
            newOrder.orderTime = [[orderComponents objectAtIndex:2]stringByReplacingOccurrencesOfString:@"Time: " withString:@""];
            currentOrderUp = newOrder.orderID;
            [sessionOrders setObject:newOrder forKey:newOrder.orderID];
            [delegate updateUIFromMessage:messageString
                                   ofType:choice
                              fromManager:self
                               fromMember:[connectedPeers objectForKey:peer]];
            break;
        }
        case SMLocalMessage:
        {
            [delegate updateUIFromMessage:messageString
                                   ofType:choice
                              fromManager:self
                               fromMember:[connectedPeers objectForKey:peer]];
            break;
        }
        case SMDeclineInvitation:
        {
            // remove from connected peers array
            [connectedPeers removeObjectForKey:peer];
            [delegate updateUIFromMessage:messageString
                                   ofType:choice
                              fromManager:self
                               fromMember:[connectedPeers objectForKey:peer]];
            break;
        }
        case SMAcceptInvitation:
        {
            //parse string
            NSArray *components = [messageString componentsSeparatedByString:@"|"];
            //0--> orderID
            //1--> memberID
            //2--> peerID
            if (![[sessionOrders objectForKey:[components objectAtIndex:0]]members])
            {//create the array
                [[sessionOrders objectForKey:[components objectAtIndex:0]]setMembers:[[NSMutableArray alloc]initWithObjects:[components objectAtIndex:1], nil]];
            }
            else
            {
                [[[sessionOrders objectForKey:[components objectAtIndex:0]]members]addObject:[components objectAtIndex:1]];
            }
            [[availablePeers objectForKey:[components objectAtIndex:1]]setPeerID:[components objectAtIndex:2]];
            [delegate updateUIFromMessage:messageString
                                   ofType:choice
                              fromManager:self
                               fromMember:[connectedPeers objectForKey:peer]];
            break;
        }
        case SMCancelOrder:
        {
            
            NSArray *parsedMessages = [messageString componentsSeparatedByString:@"|"];
            //0 -->[(OrderUp*)object orderID],
            //1 -->[[(OrderUp*)object orderOwner]peerID],
            //2 -->[(OrderUp*)object orderText]];
            OrderUp *targetOrder = [[OrderUp alloc]init];
            targetOrder.orderID = [parsedMessages objectAtIndex:0];
            
            targetOrder.orderOwner = [connectedPeers objectForKey:[parsedMessages objectAtIndex:1]];
            targetOrder.orderText = [parsedMessages objectAtIndex:2];
            
            if ([[sessionOrders objectForKey:targetOrder.orderOwner.peerID]objectForKey:targetOrder.orderID] != nil) //the order does exists
            {
                [[sessionOrders objectForKey:targetOrder.orderOwner.peerID]removeObjectForKey:targetOrder.orderID]; // remove the order
            }
            else
            {
                NSLog(@"Cannot remove order : [%@] because it does not exists...", targetOrder.orderID);
            }
            break;
        }
        case SMAddOrder:
        {
            NSArray *parsedMessages = [messageString componentsSeparatedByString:@"|"];
            //0 -->[(OrderUp*)object orderID],
            //1 -->[[(OrderUp*)object orderOwner]peerID],
            //2 -->[(OrderUp*)object orderText]];
            
            OrderUp *newOrder = [[OrderUp alloc]init];
            newOrder.orderID = [parsedMessages objectAtIndex:0];
            
            newOrder.orderOwner = [connectedPeers objectForKey:[parsedMessages objectAtIndex:1]];
            newOrder.orderText = [parsedMessages objectAtIndex:2];
            if ([sessionOrders objectForKey:newOrder.orderOwner.peerID] != nil) // this member already has an existing order
            {
                [[sessionOrders objectForKey:newOrder.orderOwner.peerID]setObject:newOrder forKey:newOrder.orderID]; // add a new order to the existing dictionary
            }
            else // this is the member's first order
            {
                [sessionOrders setObject:[[NSMutableDictionary alloc]initWithObjectsAndKeys:newOrder,newOrder.orderID, nil] forKey:newOrder.orderOwner.peerID]; // create a dictionary and add the new order
            }
            
            break;
        }
        case SMChangeOrder:
        {
            NSArray *parsedMessages = [messageString componentsSeparatedByString:@"|"];
            //0 -->[(OrderUp*)object orderID],
            //1 -->[[(OrderUp*)object orderOwner]peerID],
            //2 -->[(OrderUp*)object orderText]];
            OrderUp *modOrder = [[OrderUp alloc]init];
            modOrder.orderID = [parsedMessages objectAtIndex:0];
            
            modOrder.orderOwner = [connectedPeers objectForKey:[parsedMessages objectAtIndex:1]];
            modOrder.orderText = [parsedMessages objectAtIndex:2];

            if ([[sessionOrders objectForKey:modOrder.orderOwner.peerID]objectForKey:modOrder.orderID] != nil) //the order does exists
            {
                [[sessionOrders objectForKey:modOrder.orderOwner.peerID]setObject:modOrder forKey:modOrder.orderID]; // replace object with the mod'd one
            }
            else
            {
                NSLog(@"Cannot change order : [%@] because it does not exists.", modOrder.orderID);
            }
            break;
        }
        case SMAlertMessage:
        {
            [delegate updateUIFromMessage:messageString
                                   ofType:choice
                              fromManager:self
                               fromMember:[connectedPeers objectForKey:peer]];
            break;
        }
        case SMOrderUpClosed:
        {
//            NSArray *parsedMessages = [messageString componentsSeparatedByString:@"|"];
//            //0 -->orderID
//            //1 -->orderText
            NSLog(@"message received to close party %@", messageString);
            [pastOrders setObject: [sessionOrders objectForKey:messageString]
                           forKey:messageString];
            [delegate updateUIFromMessage:messageString
                                   ofType:choice
                              fromManager:self
                               fromMember:[connectedPeers objectForKey:peer]];
            break;
        }
            
        default:
        {
            // Unknown message received!
            NSLog(@"Unknown message received by member [%@]", peer);
        }
            break;
    }

}


-(void)updateOrderInfoWith:(OrderUp*)newOrder fromMember:(Member*)member
{
    int changeType;
    if (![sessionOrders objectForKey:member.peerID]) //member does not have existing order
    {
        // create a new MutableDictionary and add the order under the peerid key
        [sessionOrders setObject:[[NSMutableDictionary alloc]initWithObjectsAndKeys:newOrder, newOrder.orderID, nil] forKey:member.peerID];
        changeType = SMAddOrder;
        //send message to add new order to peer devices
        [self sendMessageWithTitle:nil
                           andBody:newOrder
                            ofType:changeType
                           toPeers:[connectedPeers allKeys]];
    }
    else if ([sessionOrders objectForKey:member.peerID] && ![[sessionOrders objectForKey:member.peerID]objectForKey:newOrder.orderID])// member has existing order and adding a new one.
    {
        // add the new order to peerID's MutableDictionary
        [[sessionOrders objectForKey:member.peerID]setObject:newOrder
                                                      forKey:newOrder.orderID];
        changeType = SMAddOrder;
        //send message to add new order to peer devices
        [self sendMessageWithTitle:nil
                           andBody:newOrder
                            ofType:changeType
                           toPeers:[connectedPeers allKeys]];
    }
    else if ([sessionOrders objectForKey:member.peerID] && [[sessionOrders objectForKey:member.peerID]objectForKey:newOrder.orderID]) // member is updating existing order
    {
        // remove order with orderID in Dictionary with peerID
        [[sessionOrders objectForKey:member.peerID] removeObjectForKey:newOrder.orderID];
        // replace order with newOrder
        [[sessionOrders objectForKey:member.peerID] setObject:newOrder
                                                       forKey:newOrder.orderID];
        changeType = SMChangeOrder;
        //send message to change order on peer devices
        [self sendMessageWithTitle:nil
                           andBody:newOrder
                            ofType:changeType
                           toPeers:[connectedPeers allKeys]];
    }
    else //error
    {
        changeType = SMOrderError;
    }
    
    // call to the manager's delegate to update UI data
    [delegate updateUIWithOrder:newOrder
                     FromMember:member
                 withChangeType:changeType
                    fromManager:self];
}

-(void)removeOrderInfoWithOrderId:(NSString*)orderId fromMember:(Member*)member
{
    int changeType;
    if ([sessionOrders objectForKey:member.peerID]) // member does have existing order(s)
    {
        // remove the order from the dictionary at key peerID
        [[sessionOrders objectForKey:member.peerID]removeObjectForKey:orderId];
        //send message to remove order from peer devices
        changeType = SMCancelOrder;
    }
    else // error
    {
        changeType = SMOrderError;
    }
    
    // call to manager's delegate to update UI data
    [delegate updateUIWithOrder:nil
                     FromMember:member
                 withChangeType:changeType
                    fromManager:self];
}

#pragma mark GKSession Delegate methods

-(void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    if (![availablePeers objectForKey:peerID]) {
        [availablePeers setObject:peerID forKey:peerID];
    }
    if (state == 0)
    {
        [memberSession connectToPeer:peerID withTimeout:40.0];
    }
    
    
#ifdef DEBUG
//    NSLog(@"OrderUpPeer : [peer --> %@] changed state (%d)", peerID,state );
#endif
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    [memberSession acceptConnectionFromPeer:peerID error:nil];
    if (![connectedPeers objectForKey:peerID])
    {
        Member *newMember = [[Member alloc]init];
        newMember.peerID = peerID;
        newMember.name = session.displayName;
        [connectedPeers setObject:newMember forKey:peerID];
    }
#ifdef DEBUG
//	NSLog(@"OrderUpPeer: connection request from peer %@", peerID);
#endif
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
#ifdef DEBUG
//	NSLog(@"OrderUpPeer: connection with peer %@ failed %@", peerID, error);
#endif
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
#ifdef DEBUG
//	NSLog(@"OrderUpPeer: session failed %@", error);
#endif
}


@end
