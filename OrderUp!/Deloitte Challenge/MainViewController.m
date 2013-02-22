//
//  MainViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 1/28/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize appDelegate;
@synthesize createButton, joinButton, ordersButton;
@synthesize logo;
@synthesize name;
@synthesize launch;

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
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    /**********************************************
                Marked for Removal
     Please Note that when the DataFetcher is 
     init'd it automatically retrieves the needed
     data! It is stored in appDelegate.xmlArray
     *********************************************/
    fetcher = [[DataFetcher alloc]init];
    
    //[_buttons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,3)]];
    
    launch = YES;
    
    // assign fonts to the home buttons
    [self.createButton applyDeloitteStyle];
    [self.joinButton applyDeloitteStyle];
    [self.ordersButton applyDeloitteStyle];
    
    self.name.font = [UIFont deloitteFontWithSize:12.0f];
    self.name.text = @"Deloitte Mobile Challenge\nMiddle Tennessee State University";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    if (launch)
    {
        // prepare UI for intro animation
        [self prepareForIntroAnimation];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (launch)
    {
        // perform UI intro animatino
        [self performIntroAnimation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Intro Animation Methods

// prepares the UI for animated introduction
- (void)prepareForIntroAnimation
{
    // hide all buttons
    //((UIButton*)[_buttons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,2)]]).alpha = 0.0f;
    self.createButton.alpha = 0.0f;
    self.joinButton.alpha = 0.0f;
    self.ordersButton.alpha = 0.0f;
    
    // disable all buttons
    //((UIButton*)[_buttons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]]).enabled = NO;
    self.createButton.enabled = NO;
    self.joinButton.enabled = NO;
    self.ordersButton.enabled = NO;
    
    // hide logo
    self.logo.hidden = YES;
    
    // hide name
    self.name.alpha = 0.0f;
}

// performs the intro animations
- (void)performIntroAnimation
{
    self.logo.hidden = NO;
    CGPoint point = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height * 2.0f);
    self.logo.center = point;
    
    // logo flies in from bottom
    [UIView animateWithDuration:0.65f
                          delay:0.5f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
                    {
                        self.logo.center = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 5.0f);
                    }
                     completion:nil];
    
    // fades buttons in
    [UIView animateWithDuration:0.5f
                          delay:1.2f
                        options:UIViewAnimationCurveEaseOut
                     animations:^
                    {
                        // show all buttons
                        //((UIButton*)[_buttons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]]).alpha = 1.0f;
                        self.createButton.alpha = 1.0f;
                        self.joinButton.alpha = 1.0f;
                        self.ordersButton.alpha = 1.0f;
                        
                        // show name
                        self.name.alpha = 0.7f;
                    }
                     completion:^(BOOL finished)
                    {
                        // reenable all buttons after animation is over
                        //((UIButton*)[_buttons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]]).enabled = YES;
                        self.createButton.enabled = YES;
                        self.joinButton.enabled = YES;
                        self.ordersButton.enabled = YES;
                    }];
    
    launch = NO;
}
#pragma mark SessionMangerDelegate Methods




@end
