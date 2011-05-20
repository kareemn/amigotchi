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
#import "AmigoCallbackDelegate.h"


@interface AmigoPetView : CCNode<CCTargetedTouchDelegate> {

}

- (id) initWithHappiness:(int)happiness andHunger:(int)hunger andBathroom:(int)bathroom andAge:(int)age;
- (void) setSprites;
- (void) setButtons;
- (void) refreshSpriteswithHappiness:(int)happiness andHunger:(int)hunger andBathroom:(int)bathroom andAge:(int)age;
- (void) handleButton:(id)sender;
- (void) drawPoops:(int)numPoops;
- (void) drawBarsHappiness:(int)happiness Hunger:(int)hunger;


@property (nonatomic, retain) CCSprite * mySprite;
@property (nonatomic, retain) NSMutableArray * poops;
@property (nonatomic, retain) CCMenu * buttons;
@property (nonatomic, retain) CCSpriteFrameCache * cache;

@property (nonatomic, retain) CCAnimation * idleAnimation;
@property (nonatomic, retain) CCAnimation * pokeAnimation;

@property (nonatomic, retain) CCRepeatForever * idleAction;
@property (nonatomic, retain) CCRepeatForever * pokeAction;

@property (nonatomic, retain) CCSprite * happinessBar;
@property (nonatomic, retain) CCSprite * hungerBar;

@end
