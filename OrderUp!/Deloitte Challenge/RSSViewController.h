//
//  RSSViewController.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/16/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) NSString *html;

@end
