//
//  OrderUp.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/4/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface OrderUp : NSObject
@property (strong, nonatomic) NSString *orderID, *orderText;
@property (strong, nonatomic) Member *orderOwner;

@property (strong, nonatomic) NSString *orderTitle, *orderLocation, *orderTime;
@property (strong, nonatomic) NSMutableArray *members;
@property (strong, nonatomic) NSMutableDictionary *individualOrders;
-(NSString*)getStringOfOrderUp:(OrderUp *) party;

@end
