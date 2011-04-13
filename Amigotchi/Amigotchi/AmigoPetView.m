//
//  AmigoPetView.m
//  Amigotchi
//
//  Created by Elliott Kipper on 4/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "AmigoPetView.h"


@implementation AmigoPetView
@synthesize mySprite, idleAnimation, pokeAnimation, cache;

id idleAction;
id pokeAction;

-(id)init
{
    if((self = [super init]))
    {
        self.cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        self.idleAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
        self.pokeAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
        
        [self setSprites];
        [self addChild:mySprite];
    }
    return self;
}

-(void) setSprites
{
    [cache addSpriteFramesWithFile:@"dragon.plist"];
    
    //idleAnimation
    for(int i = 1; i < 3; i++)
    {
        NSString * fname = [NSString stringWithFormat:@"dragon_idle_%i.png", i];
        [self.idleAnimation addFrame:[self.cache spriteFrameByName:fname]];
    }
    idleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.idleAnimation]];
    
    //pokeAnimation
    [self.pokeAnimation addFrame:[self.cache spriteFrameByName:@"dragon_poked.png"]];
    pokeAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:pokeAnimation]];
    
    //Set and go!
    self.mySprite = [CCSprite spriteWithSpriteFrameName:@"dragon_idle_1.png"];
    [self.mySprite runAction:idleAction];
}
@end
