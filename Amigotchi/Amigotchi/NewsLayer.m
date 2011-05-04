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
        self.view.position = ccp(size.width/2, (size.height + self.view.newsStand.contentSize.height/2.5));
    }
    
    return self;
}

-(void) enqueue:(News *)news
{
    
}

-(void) showAllNews
{
    
}

-(void) dealloc
{
    newsQueue_ = nil;
    view_ = nil;
    [super dealloc];
}

@end
