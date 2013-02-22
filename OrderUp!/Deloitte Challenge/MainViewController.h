//
//  MainViewController.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 1/28/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+DeloitteAdditions.h"
#import "AppDelegate.h"
#import "DataFetcher.h"


@interface MainViewController : UIViewController  <SessionManagerDelegate>
{
    DataFetcher *fetcher;
}

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIButton *ordersButton;
@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *buttons;

@property (nonatomic) BOOL launch;

@end
