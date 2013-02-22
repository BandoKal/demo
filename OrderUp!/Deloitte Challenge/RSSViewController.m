//
//  RSSViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/16/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "RSSViewController.h"

@interface RSSViewController ()

@end

@implementation RSSViewController
@synthesize html;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.webView loadHTMLString:html baseURL:nil];
    self.webView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
