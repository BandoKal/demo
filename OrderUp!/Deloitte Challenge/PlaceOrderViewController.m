//
//  PlaceOrderViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/18/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "PlaceOrderViewController.h"

@interface PlaceOrderViewController ()

@end

@implementation PlaceOrderViewController
@synthesize orderTextField,myOrderHelp;
@synthesize appDelegate;
@synthesize popoverController;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myOrderHelpClicked:(id)sender {
    // exits textField editing
    [self.orderTextField resignFirstResponder];
    
    // change bool value in appdelegate array
    [appDelegate.helpButtonValues setValue:@"YES" forKey:@"myOrder"];
    
    // create popover
    if (self.popoverController)
    {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
    }
    else
    {
        UIViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        
        self.popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
        [self.popoverController presentPopoverFromRect:myOrderHelp.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
    }

}

- (IBAction)addOrder:(id)sender {
    // save order here
}

@end
