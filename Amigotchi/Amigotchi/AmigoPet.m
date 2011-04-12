//
//  Pet.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoPet.h"

@implementation AmigoPet
@synthesize /*theGame,*/ mySprite, type;

CCAnimation * pokeAnimation;

-(id) init
{
    if((self = [super init]))
    {
        self.type = @"dragon";
        [self setSpritesForType:self.type];
        
        [self addChild:self.mySprite];
        NSLog(@"init: Adding sprite to AmigoPet.\n");
    }
    return (self);
}

-(void)setSpritesForType:(NSString *)_type
{
    if(_type == @"dragon")
    {
        CCSpriteFrameCache * cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"dragon.plist"];
        
        //Idle animation
        CCAnimation * idleAnimation = [[CCAnimation alloc] initWithName:@"idle" delay:1.0/2];
        
        for(int i = 1; i < 3; i++)
        {
            NSString * fname = [NSString stringWithFormat:@"dragon_idle_%i.png", i];
            [idleAnimation addFrame:[cache spriteFrameByName:fname]];
        }
        id idleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:idleAnimation]];
        
        //Poke animation
        //pokeAnimation = [[CCAnimation alloc] initWithName:@"idle" delay:1.0/2];
        //[pokeAnimation addFrame:[cache spriteFrameByName:@"dragon_poked.png"]];
        
        self.mySprite = [CCSprite spriteWithSpriteFrameName:@"dragon_idle_1.png"];
        [self.mySprite runAction:idleAction];
    }
}

-(void)poke
{
    //Poke animation
    //id pokeAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:pokeAnimation]];
}

//Overwritten functions

-(CGRect)rect
{
	CGFloat width = self.mySprite.contentSize.width;
	CGFloat height = self.mySprite.contentSize.height;
	
	CGFloat x = (self.mySprite.position.x) - (width/2);
	CGFloat y = self.mySprite.position.y - (height/2);
	
	CGRect c = CGRectMake(x, y, width, height);
	return c;
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

-(BOOL)ccTouchBegan:(UITouch*) touch  withEvent:(UIEvent*) event
{
    if ( ![self containsTouchLocation:touch]) return NO;
    NSLog(@"AmigoPet ccTouchBegan\n");
    //[self.mySprite runAction:pokeAction];
    return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
}

-(void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

-(void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}


@end
