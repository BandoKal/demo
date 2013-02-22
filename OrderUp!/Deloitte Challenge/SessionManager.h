//
//  SessionManager.h
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//
//    2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.


// Available Constants: SESSION_ID

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "Member.h"
#import "OrderUp.h"

typedef NS_ENUM(NSUInteger, MessageType ){ // enum type for the type of messages being sent
    
    SMInvitationMessage = 0, // message is intended to be an UIAlertView     {title|alert_body}
    SMLocalMessage = 1, // message can be used to update table or other "non" user interaction label {message_body}
    SMDeclineInvitation = 2, 
    SMAcceptInvitation = 4,
    SMCancelOrder = 5, // order is to be removed...
    SMAddOrder = 6, // order is to be added.
                    // Note: member is added to connectedPeers property if selected
    SMChangeOrder = 7, // order data is being modified.
    SMAlertMessage = 3, // this can be an alertview like "order is here!"
    SMOrderUpClosed = 8, // order up party is over :-(
    SMOrderError = 99 // error as occured with processing order
};




@class SessionManager;
@protocol SessionManagerDelegate <NSObject>

@required
// This method is called by the Session Manager when
// a message has been received from a peer.
// param list:
//          message => string of the message
//          messageType => enum type that will tell receiver
//                     how manager intends the message to
//                     be handled. see ENUM typdef above
//          manager => the sending manager
-(void)updateUIFromMessage:(NSString*) message
                    ofType:(MessageType) messageType
               fromManager: (SessionManager*) manager
                fromMember: (Member*) member;
/*******************************************************
//This is an example of the delegate method implementation for an alertview
 
 -(void)updateUIFromMessage:(NSString*) message
                     ofType:(MessageType) messageType
                fromManager:(SessionManager*) manager
                 fromMember: (Member*) member
 {
    switch (messageType) {
            case SMAlertMessage:
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Party Invitation"
                                                               message:message
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles: nil];
                [alert show];
 
                break;
            }
 
            case SMLocalMessage:
            {
                NSLog(@"Message Received!!! [ %@] ", message);
                break;
            }
 
            case SMDeclineInvitation:
            {
                [appDelegate.manager invitationDeclinedByMember: member];
                break;
            }
 
            case SMAcceptInvitation:
            {
                [appDelegate.manager inivitationAcceptedByMember: member];
            }
            default:
                break;
        }
 }

 ********************************************************/


// This method is called by Session Manager when
// member states are changed. Please note member states
// can be changed by user events or network events.
// param list:
//              localOrder => the target order
//              localMember => target member (entire member object passed)
//              orderChangeType => enum type that will tell receiver
//                                 what type of modification is happening
//                                 to the member. see ENUM typedef above
//              manager => the sending manager
-(void)updateUIWithOrder: (OrderUp*) localOrder
              FromMember: (Member*) localMember
          withChangeType: (MessageType) orderChangeType
             fromManager: (SessionManager*)manager;

@end


@interface SessionManager : NSObject <GKSessionDelegate>
{
    NSTimer *sessionTimer; // used for debug purposes ... this will poll available peers
    
    
}

@property (strong,nonatomic) NSMutableDictionary *connectedPeers, *availablePeers, *sessionOrders, *pastOrders;
@property (strong, nonatomic) id<SessionManagerDelegate> delegate;
@property (strong, nonatomic) GKSession *memberSession;
@property (strong, nonatomic) NSString *currentOrderUp;
@property BOOL isHost;

// Controller available methods

// init
// begins a session
-(id)init;

// sendInvitationsWithMessage: ToPeers:
// use this method to send out invitations to a new OrderUp! Party you can make
// this will appear as an alert on the member's device.
// params:
//          title => The Title of the Alert
//          message => what you want the body of the message to say
//          peers => this is the array of peerID's that you want to send to
//                   Note they must be connected peers. pass nil if you want
//                   to send to all connected peers.
-(void)sendInvitationsWithTitle: (NSString*) title andMessage: (id)message ToPeers: (NSArray*)peers;


// sendMessage: ofType: toPeer:
// use this if you want to send a message that is not an new invitation
// params:
//          title => Title if the message if it is an alert if not you may leave blank
//          message => string of the message to send ... if this is an order mod then
//                      then you can pass the order object!
//          messageType => how does/do the receiver(s) handle the message
//          peerID => this is an array of string that are the unique peerID of the members
//      ***** Note: Pass 'nil' as peerID to send message to all connected peers****
-(void)sendMessageWithTitle:(NSString*) title andBody: (id) object ofType: (MessageType)messageType toPeers: (NSArray*) peerIDs;

// invitationDeclinedByMember:
// This method will let the Session Manager know to remove a member
// from the connected peers list so that user no longer receives
// messages.     Call example:  [appDelegate.manager inivitationDeclinedByMember: aMemberObj];
-(void)invitationDeclinedByMember: (Member*) member;

// invitationAcceptedByMember:
// This method will let the Session Manager know to add a member
// to the connected peers list so that user can receive and send
// messages.  Call example:  [appDelegate.manager inivitationAcceptedByMember: aMemberObj];
-(void)inivitationAcceptedByMember: (Member*) member;

// updateOrderInfoWith: fromMember:
// Called when an order needs to be added/modified
-(void)updateOrderInfoWith:(OrderUp*)newOrder fromMember:(Member*)member;

-(void)removeOrderInfoWithOrderId:(NSString*)orderId fromMember:(Member*)member;


// Internal methods
-(void)beginSession;
-(void)endSession;
-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)contex;

//-(void)sendTest;



@end
