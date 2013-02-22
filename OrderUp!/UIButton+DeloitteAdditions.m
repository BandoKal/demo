//
//  UIButton+DeloitteAdditions.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 1/28/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "UIButton+DeloitteAdditions.h"

@implementation UIButton (DeloitteAdditions)

- (void)applyDeloitteStyle
{
    self.titleLabel.font = [UIFont deloitteFontWithSize:20.0f];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"Button"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    UIImage *pressedImage = [[UIImage imageNamed:@"ButtonPressed"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    [self setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
}

@end
