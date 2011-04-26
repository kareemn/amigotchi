//
//  AmigoPetView.m
//  Amigotchi
//
//  Created by Elliott Kipper on 4/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "AmigoPetView.h"
#import "AmigoConfig.h"

@implementation AmigoPetView
@synthesize mySprite, idleAnimation, unhappyIdleAnimation, pokeAnimation, cache, pokeAction, idleAction, unhappyIdleAction;

//id idleAction;
//id pokeAction;

-(id)init
{
    if((self = [super init]))
    {
        self.cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        self.idleAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
        self.unhappyIdleAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
        self.pokeAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
        
        [self setSprites];
        //Set and go!
        self.mySprite = [CCSprite spriteWithSpriteFrameName:@"baby_penguin_idle_1.png"];
        [self.mySprite runAction:self.idleAction];
        [self addChild:mySprite];
        
        self->sae = [SimpleAudioEngine sharedEngine];
        if(self->sae != nil){
            [self->sae preloadBackgroundMusic:@"penguin_sound.mp3"];
        }
    }
    return self;
}


-(void) setSprites
{
    [cache addSpriteFramesWithFile:@"penguin.plist"];
    
    //idleAnimation
    for(int i = 1; i < 5; i++)
    {
        NSString * fname = [NSString stringWithFormat:@"baby_penguin_idle_%i.png", i];
        [self.idleAnimation addFrame:[self.cache spriteFrameByName:fname]];
    }
    self.idleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.idleAnimation]];
    
    //unhappyIdleAnimation
    /*
    for(int i = 1; i < 3; i++)
    {
        NSString * fname = [NSString stringWithFormat:@"dragon_idle_unhappy_%i.png", i];
        [self.unhappyIdleAnimation addFrame:[self.cache spriteFrameByName:fname]];
    }
    self.unhappyIdleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.unhappyIdleAnimation]];
    */
    
    //pokeAnimation
    for(int i = 1; i < 3; i++){
        NSString * fname = [NSString stringWithFormat:@"baby_penguin_laugh_%i.png", i];
       [self.pokeAnimation addFrame:[self.cache spriteFrameByName:fname]];
    }
    
    self.pokeAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.pokeAnimation]];

    
    //Set and go!
    //self.mySprite = [CCSprite spriteWithSpriteFrameName:@"dragon_idle_1.png"];
    //[self.mySprite runAction:self.idleAction];
}

-(void) refreshSpriteswithHappiness:(int)happiness
{
    [self.mySprite stopAllActions];
        [self.mySprite runAction:self.idleAction];

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
    NSLog(@"AmigoPetView ccTouchBegan\n");
    [self.mySprite runAction:self.pokeAction];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"penguin_sound.mp3"];
    
    return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"AmigoPetView ccTouchEnded\n");
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self.mySprite stopAction:self.pokeAction];
    
    //NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"hey", @"ho", nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:PETVIEWCHANGE object:@"poke"]];
                                                            //Call feedSelector
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
