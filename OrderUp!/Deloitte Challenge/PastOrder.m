//
//  PastOrder.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "PastOrder.h"

@implementation PastOrder
@synthesize pastTitle, pastOrder;

- (id)initWithTitle:(NSString*)ttl andOrder:(NSString*)ord
{
    pastTitle = ttl;
    pastOrder = ord;
    
    return self;
}

@end
