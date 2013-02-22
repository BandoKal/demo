//
//  CreateViewController.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/3/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIButton+DeloitteAdditions.h"
#import "FeedEntry.h"
#import "RSSViewController.h"

@interface CreateViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableArray *rssArray;

@property (weak, nonatomic) IBOutlet UITableView *startTableView;
@property (weak, nonatomic) IBOutlet UITableView *rssTableView;

@end
