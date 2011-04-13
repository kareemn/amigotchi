//
//  AmigoPetView.h
//  Amigotchi
//
//  Created by Elliott Kipper on 4/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface AmigoPetView : CCNode<CCTargetedTouchDelegate> {
    CCSprite *          mySprite;
    CCAnimation *       idleAnimation;
    CCAnimation *       pokeAnimation;
    CCSpriteFrameCache *cache;
    CCRepeatForever *   idleAction;
    CCRepeatForever *   pokeAction;
}

-(void)setSprites;

@property (nonatomic, retain) CCSprite * mySprite;
@property (nonatomic, retain) CCAnimation * idleAnimation;
@property (nonatomic, retain) CCAnimation * pokeAnimation;
@property (nonatomic, retain) CCSpriteFrameCache * cache;
@property (nonatomic, retain) CCRepeatForever * idleAction;
@property (nonatomic, retain) CCRepeatForever * pokeAction;
@end
