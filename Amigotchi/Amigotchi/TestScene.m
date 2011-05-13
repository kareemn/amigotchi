//
//  TestScene.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "TestScene.h"


@implementation TestScene
@synthesize layer = layer_;

-(id) init
{
    if( (self=[super init]))
    {
        self.layer = [[CCLayer alloc] init];
        
        CCSprite * lol = [CCSprite spriteWithFile:@"Icon.png"];
        lol.position = ccp(200,200);
        [self.layer addChild:lol];
        [self addChild:self.layer];
    }
    return self;
}

@end
