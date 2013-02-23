//
//  Order.h
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/23/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"
#import "OrderUp.h"

@interface Order : NSObject

@property (strong, nonatomic) Member *orderOwner;
@property (strong, nonatomic) OrderUp *orderUpParty;
@property (strong, nonatomic) NSString *orderText;

@end
