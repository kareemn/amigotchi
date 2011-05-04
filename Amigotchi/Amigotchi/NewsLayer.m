//
//  NewsLayer.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/3/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "NewsLayer.h"


@implementation NewsLayer
@synthesize newsQueue = newsQueue_, view = view_;

-(id) init
{
    if((self = [super init]))
    {
        self.newsQueue = [NSMutableArray array];
        NewsView *theView = [[NewsView alloc] initWithString:@"Welcome back!"]; 
        self.view = theView;
        [theView release];
        
        [self addChild:self.view];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.view.position = ccp(size.width/2, (size.height + self.view.newsStand.contentSize.height/2.0));
    }
    
    return self;
}
-(void)newsWithString:(NSString *)aString
{
    [self removeChild:self.view cleanup:YES];
    self.view = nil;
    
    NewsView *theView = [[NewsView alloc] initWithString:aString]; 
    self.view = theView;
    [theView release];
    
    [self addChild:self.view];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    self.view.position = ccp(size.width/2, (size.height + self.view.newsStand.contentSize.height/2.0));
    [self.view display];
}

-(void) enqueue:(NSString *)aString
{
    [self.newsQueue addObject:aString];
}

-(void) showAllNews
{
    //NSLog(@"showAllNews: Showing %d news stories.\n", [self.newsQueue count]);
    if([self.newsQueue count] > 0)
    {
        NSLog([self.newsQueue objectAtIndex:0]);
        [self.newsQueue removeObjectAtIndex:0];
        [self showAllNews];
    }
    
}

-(void) dealloc
{
    newsQueue_ = nil;
    view_ = nil;
    [super dealloc];
}

@end
