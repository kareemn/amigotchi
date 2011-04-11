//
//  Pet.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoPet.h"

@implementation AmigoPet
@synthesize /*theGame,*/ mySprite;

-(id) init
{
    if((self = [super init]))
    {
        //self.theGame = game;
        
        CCSpriteFrameCache * cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"dragon.plist"];
        
        CCAnimation * idleAnimation = [[CCAnimation alloc] initWithName:@"idle" delay:1.0/2];
        
        for(int i = 1; i < 3; i++)
        {
            NSString * fname = [NSString stringWithFormat:@"dragon_idle_%i.png", i];
            [idleAnimation addFrame:[cache spriteFrameByName:fname]];
        }
        id idleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:idleAnimation]];
        
        self.mySprite = [CCSprite spriteWithSpriteFrameName:@"dragon_idle_1.png"];
        [self.mySprite runAction:idleAction];
        
        [self addChild:self.mySprite];
        NSLog(@"init: Adding sprite to AmigoPet.\n");
        //[game addChild:self];
    }
    return (self);
}
@end
