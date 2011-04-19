//
//  EnvironmentView.m
//  Amigotchi
//
//  Created by Elliott Kipper on 4/19/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "EnvironmentView.h"


@implementation EnvironmentView
@synthesize sky, ground;
-(id)init
{
    if((self = [super init]))
    {
        // ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize]; 
        
        CCSpriteFrameCache * cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"background.plist"];
        
        self.sky = [CCSprite spriteWithSpriteFrameName:@"sky.png"];
        self.ground = [CCSprite spriteWithSpriteFrameName:@"grass.png"];
        
        self.sky.scale = self.ground.scale = 0.5;
        self.sky.position = self.ground.position = ccp(size.width/2, size.height/2);
        
        [self addChild:self.sky z:SKY_LAYER];
        [self addChild:self.ground z:GROUND_LAYER];
    }
    return (self);
}
@end
