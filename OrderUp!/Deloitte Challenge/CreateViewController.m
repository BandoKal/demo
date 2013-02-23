//
//  CreateViewController.m
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 2/3/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()
{
    BOOL isPad;
}

@end

@implementation CreateViewController
@synthesize appDelegate;
@synthesize rssArray;
@synthesize startTableView, rssTableView;

NSString *htmlString;

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
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        isPad = YES;
    }
    else
    {
        isPad = NO;
    }
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    startTableView.delegate = self;
    startTableView.dataSource = self;
    rssTableView.delegate = self;
    rssTableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [startTableView reloadData];
    [rssTableView reloadData];
    
    appDelegate.members = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"start"])
    {
        // ... 
    }
    else if ([segue.identifier isEqualToString:@"rssFeed"])
    {
        RSSViewController *nextView = [segue destinationViewController];
        nextView.html = [NSString stringWithString:htmlString];
    }
}

#pragma mark - TableView Delegate

// asks the delegate for the ehight to use for a row in a specified location
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == startTableView)
        return 75;
    else if (isPad)
        return 245;
    else
        return 60;

}

// tells the delegate that the specified row is now selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == startTableView)
    {
        [self performSegueWithIdentifier:@"start" sender:self];
    }
    else
    {
        htmlString = [NSString stringWithString:[[appDelegate.xmlArray objectAtIndex:[[rssTableView indexPathForSelectedRow] row]] content]];

        [self performSegueWithIdentifier:@"rssFeed" sender:self];
    }
}

// tells the delegate that the specified row is now unselected
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableView Data Source

// asks the data source for a cell to insert in a particular location of the table view (required)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    UITableViewCell *cell;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == startTableView)
    {
        cellIdentifier = @"startCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    else if (tableView == rssTableView)
    {
        cellIdentifier = @"rssCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if (isPad)
        {
            UIWebView *webview = (UIWebView*)[cell viewWithTag:1];
            NSString *urlString = [[[appDelegate.xmlArray objectAtIndex:indexPath.row]content] stringByReplacingOccurrencesOfString:@"Review of" withString:@"Review of "];
            [webview loadHTMLString: urlString baseURL:[NSURL URLWithString:[[appDelegate.xmlArray objectAtIndex:indexPath.row]content]] ];
            [webview setBackgroundColor:[UIColor clearColor]];
            [webview setOpaque:NO];
            UILabel * title = (UILabel*)[cell viewWithTag:2];
            NSString *myString = [[appDelegate.xmlArray objectAtIndex:indexPath.row] title];
            NSArray *myArray = [myString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
            title.text = [myArray objectAtIndex:0];
            
        }
        else
        {
            NSString *myString = [[appDelegate.xmlArray objectAtIndex:indexPath.row] title];
            NSArray *myArray = [myString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
            cell.textLabel.text = [myArray objectAtIndex:0];
            //        cell.textLabel.text = [[appDelegate.xmlArray objectAtIndex:indexPath.row] title];
            cell.textLabel.numberOfLines = 2;
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        }
    }
    
    return cell;
}

// asks the data source to return the number of sections in the table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// tells the data source to return the number of rows in a given section of a table view (required)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    if (tableView == startTableView)
        return 1;
    else if (tableView == rssTableView)
        return [appDelegate.xmlArray count];
    
    return 0;
}

// asks the data source to return the titles for the sections for a table view
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // used for index list
    return nil;
}

// asks the data source for the title of the header of teh specified section of the table view
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == startTableView)
        return @" ";
    else if (tableView == rssTableView)
        return @"Places Near You";
    
    return nil;
}

@end
