//
//  PastOrder.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PastOrder : NSObject

@property (strong, nonatomic) NSString *pastTitle, *pastOrder;

- (id)initWithTitle:(NSString*)ttl andOrder:(NSString*)ord;

@end
