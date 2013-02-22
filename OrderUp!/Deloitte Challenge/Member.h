//
//  Member.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/4/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject
@property (strong, nonatomic) NSString *peerID;
@property (strong, nonatomic) NSString *memberID;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* phone;

- (id)initWithName:(NSString*)n andPhone:(NSString*)p;

@end
