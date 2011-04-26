//
//  AmigoPetView.h
//  Amigotchi
//
//  Created by Elliott Kipper on 4/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AmigoConfig.h"
#import "SimpleAudioEngine.h"


@interface AmigoPetView : CCNode<CCTargetedTouchDelegate> {
    SimpleAudioEngine *sae;
}

- (void)setSprites;
- (void) refreshSpriteswithHappiness:(int)happiness;

@property (nonatomic, retain) CCSprite * mySprite;
@property (nonatomic, retain) CCAnimation * idleAnimation;
@property (nonatomic, retain) CCAnimation * unhappyIdleAnimation;
@property (nonatomic, retain) CCAnimation * pokeAnimation;
@property (nonatomic, retain) CCSpriteFrameCache * cache;
@property (nonatomic, retain) CCRepeatForever * idleAction;
@property (nonatomic, retain) CCRepeatForever * unhappyIdleAction;
@property (nonatomic, retain) CCRepeatForever * pokeAction;

@end
