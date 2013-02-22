//
//  OrderUp.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/4/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "OrderUp.h"

@implementation OrderUp
@synthesize orderID,orderOwner,orderText;
@synthesize orderTitle, orderLocation, orderTime;
@synthesize members;

-(NSString*)getStringOfOrderUp:(OrderUp *) party
{
    NSString *string = [NSString stringWithFormat:@"%@|%@|%@", orderID, orderOwner.peerID, orderText];
    return string;
}

@end
