//
//  XMLParser.m
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

-(id)init
{
    if (self = [super init])
    {
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.xmlArray = [[NSMutableArray alloc] init];
    }
    return self;
}



- (void)parser:(NSXMLParser*)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"entry"] )
    {
        aParseObject = [[FeedEntry alloc]init];
    }
    currentElementValue = nil;
}


- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString *)string
{
    NSString *newString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithString:newString];
    else
        [currentElementValue appendString:newString];

}


- (void)parser:(NSXMLParser*)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"entry"] )
    {
        if (aParseObject)
        {
            [appDelegate.xmlArray addObject:aParseObject];
            aParseObject = nil;
        }
    }
    
    @try {
        [aParseObject setValue:currentElementValue forKey:elementName];
    }
    @catch (NSException *exception)
    {
//        NSLog(@"%@" , exception.debugDescription);
    }
}
@end
