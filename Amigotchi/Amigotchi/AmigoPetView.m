//
//  AmigoPetView.m
//  Amigotchi
//
//  Created by Elliott Kipper on 4/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "AmigoPetView.h"

@implementation AmigoPetView
@synthesize mySprite, idleAnimation, unhappyIdleAnimation, pokeAnimation, cache, pokeAction, idleAction, unhappyIdleAction;
@synthesize buttons = buttons_;
@synthesize callbackDelegate = callbackDelegate_;

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
        [self setButtons];
        
        //Set and go!
        self.mySprite = [CCSprite spriteWithSpriteFrameName:@"dragon_idle_1.png"];
        [self.mySprite runAction:self.idleAction];
        [self addChild:self.mySprite];
        [self addChild:self.buttons];
        
        //Button Stuff
    }
    return self;
}

- (id) initWithCallbackDelegate: (AmigoCallbackDelegate *)delegate {
    self = [self init];
    
    if(self){
        self.callbackDelegate = delegate;
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
    self.idleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.idleAnimation]];
    
    //unhappyIdleAnimation
    for(int i = 1; i < 3; i++)
    {
        NSString * fname = [NSString stringWithFormat:@"dragon_idle_unhappy_%i.png", i];
        [self.unhappyIdleAnimation addFrame:[self.cache spriteFrameByName:fname]];
    }
    self.unhappyIdleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.unhappyIdleAnimation]];
    
    //pokeAnimation
    [self.pokeAnimation addFrame:[self.cache spriteFrameByName:@"dragon_poked.png"]];
    self.pokeAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.pokeAnimation]];
    
    //feedButton
    //self.feedButton = [CCSprite spriteWithFile:@"Icon.png"];
    //self.feedButton.position = ccp(200, 200);
    
}

-(void) setButtons
{
    //Feed button
    CCMenuItem *feedButton = [CCMenuItemImage 
                                itemFromNormalImage:@"Icon.png" selectedImage:@"Icon-72.png" 
                                target:self selector:@selector(handleButton:)];
    
    feedButton.tag = BUTTON_FEED;
    
    
    //Checkin button
    CCMenuItem *getFoodButton = [CCMenuItemImage 
                                 itemFromNormalImage:@"Icon.png" selectedImage:@"Icon-72.png" 
                                 target:self selector:@selector(handleButton:)];
    
    getFoodButton.tag = BUTTON_CHECKIN;
    getFoodButton.position = ccp(80, 0);
    
    //map button
    CCMenuItem *mapButton = [CCMenuItemImage 
                                 itemFromNormalImage:@"Icon.png" selectedImage:@"Icon-72.png" 
                                 target:self selector:@selector(handleButton:)];
    
    mapButton.tag = BUTTON_MAP;
    mapButton.position = ccp(160, 0);
    
    //Take dump button
    
    //Make the menu
    self.buttons = [CCMenu menuWithItems:feedButton, getFoodButton, mapButton, nil];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    NSLog(@"width: %f height: %f", size.width, size.height);
    
    self.buttons.position = CGPointMake(-.4* size.width, -.9 * size.height);
}

-(void) refreshSpriteswithHappiness:(int)happiness andHunger:(int)hunger andBathroom:(int)bathroom
{
    [self.mySprite stopAllActions];
    if(happiness >= MAX_HAPPINESS/2)
    {
        [self.mySprite runAction:self.idleAction];
    }
    else
    {
        [self.mySprite runAction:self.unhappyIdleAction];
    }
}

-(void)handleButton:(id)sender
{
    NSLog(@"handleButton:: tag: %@\n", sender);
    
    CCMenuItem *clickedButton = (CCMenuItem *)sender;
    /*
     allowed callbacks on PetLayer for now to add more modify the 
     PetLayer createCallbackDelegate function
     
     @"foodButtonCallback"
     @"checkinButtonCallback"
     @"mapButtonCallback"
    */
    switch(clickedButton.tag){
        case BUTTON_FEED:
            NSLog(@"AmigoPetView::Clicked button to feed pet");
            [self.callbackDelegate performCallback:@"foodButtonCallback"];
            break;
        case BUTTON_CHECKIN:
            NSLog(@"AmigoPetView::Clicked button to checkin");
            [self.callbackDelegate performCallback:@"checkinButtonCallback"];
            break;
        case BUTTON_MAP:
            NSLog(@"AmigoPetView::Clicked button to see map");
            [self.callbackDelegate performCallback:@"mapButtonCallback"];
            break;
        default:
            break;
            
    }
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
    
    if ([self containsTouchLocation:touch])
    {
        [self.mySprite runAction:self.pokeAction];
        return YES;
    }
    return NO;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"AmigoPetView ccTouchEnded\n");
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

- (void) dealloc {
    
    [callbackDelegate_ release];
    
    [super dealloc];
}

@end
