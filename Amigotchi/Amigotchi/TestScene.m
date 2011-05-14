//
//  TestScene.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "TestScene.h"


@implementation TestScene
@synthesize layer = layer_, mapview = mapview_, mapwrapper = mapwrapper_;

-(id) init
{
    if( (self=[super init]))
    {
        self.layer = [[CCLayer alloc] init];
        
        CCSprite * lol = [CCSprite spriteWithFile:@"Icon.png"];
        lol.position = ccp(200,200);
        [self.layer addChild:lol];
        
        //Map stuff
        self.mapview = [[MKMapView alloc] init];
        [self.mapview release];
        self.mapwrapper = [CCUIViewWrapper wrapperForUIView:self.mapview];
        [self.layer addChild:self.mapwrapper];
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.mapwrapper.contentSize = size;
        
        
        //
        [self addChild:self.layer];
        [[CCScheduler sharedScheduler] scheduleSelector:@selector(popItLikesItsHot) forTarget:self interval:5.0 paused:NO];
    }
    return self;
}

-(void) popItLikesItsHot
{
    NSLog(@"popItLikeItsHot");
    [self.layer removeChild:self.mapwrapper cleanup:YES];
    [mapview_ release];
    [mapwrapper_ release];
    [[CCDirector sharedDirector] popScene];
}
@end
