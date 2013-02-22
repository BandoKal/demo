//
//  Member.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/4/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "Member.h"

@implementation Member
@synthesize peerID;
@synthesize memberID;
@synthesize name, phone;

- (id)initWithName:(NSString*)n andPhone:(NSString*)p
{
    name = n;
    phone = p;
    
    return self;
}

-(NSString*)getStringOfMember:(Member*)member
{
    NSString *string = [NSString stringWithFormat:@"|%@|",memberID];
    return string;
}


@end
