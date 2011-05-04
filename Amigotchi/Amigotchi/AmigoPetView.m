//
//  AmigoPetView.m
//  Amigotchi
//
//  Created by Elliott Kipper on 4/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "AmigoPetView.h"
@interface AmigoPetView()

@property (nonatomic, retain) CCAnimation * poopAnimation;
@property (nonatomic, retain) CCAction * poopAction;

@end

@implementation AmigoPetView
@synthesize mySprite, idleAnimation = idleAnimation_, pokeAnimation, cache, pokeAction, idleAction = idleAction_;
@synthesize buttons = buttons_;
@synthesize callbackDelegate = callbackDelegate_;
@synthesize poops = poops_;
@synthesize poopAnimation = poopAnimation_, poopAction = poopAction_;

//id idleAction;
//id pokeAction;

-(id)init
{
    if((self = [super init]))
    {
        self.cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        self.poops = [NSMutableArray arrayWithCapacity:MAX_BATHROOM];
        
        self.idleAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
        self.pokeAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
        self.poopAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
        
        [self.idleAnimation release];
        [self.pokeAnimation release];
        [self.poopAnimation release];
        
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
    [self.cache addSpriteFramesWithFile:@"dragon.plist"];
    
    //idleAnimation
    for(int i = 1; i < 3; i++)
    {
        NSString * fname = [NSString stringWithFormat:@"dragon_idle_%i.png", i];
        [self.idleAnimation addFrame:[self.cache spriteFrameByName:fname]];
    }
    self.idleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.idleAnimation]];
    
    //pokeAnimation
    [self.pokeAnimation addFrame:[self.cache spriteFrameByName:@"dragon_poked.png"]];
    self.pokeAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.pokeAnimation]];
    
    
    //Poop!
    for(int i = 1; i < 5; i++)
    {
        NSString * fname = [NSString stringWithFormat:@"poop_%i.png", i];
        [self.poopAnimation addFrame:[self.cache spriteFrameByName:fname]];
    }
    self.poopAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.poopAnimation]];
    
    for(int i = 0; i < MAX_BATHROOM; i++)
    {
        CCSprite * poop = [CCSprite spriteWithSpriteFrameName:@"poop_1.png"];
        
        poop.position = self.mySprite.position;
        CCSprite * whatever = [CCSprite spriteWithSpriteFrameName:@"dragon_idle_1.png"];
        int newY = poop.position.y - whatever.contentSize.height/2;
        poop.position = ccp(3000, newY);
        
        [self.poops addObject:poop];
        [self addChild:poop z:PET_LAYER];
        [poop release];
    }
}

-(void) setButtons
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    int numButtons = 4;
    
    float spacing = 2*((size.width) / numButtons); //The 2 is from the scaling in the layer.
    float curX = (self.mySprite.position.x) - (spacing * (numButtons/2.0));
    NSLog(@"spacing: %f.\n", spacing);
    
    [self.cache addSpriteFramesWithFile:@"buttons.plist"];
    
    //Feed button
    CCMenuItem *feedButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"feed_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"feed_button_pressed.png"] target:self selector:@selector(handleButton:)];
    curX += feedButton.contentSize.width/2;
    
    feedButton.tag = BUTTON_FEED;
    feedButton.position = ccp(curX, 0);
    NSLog(@"Placing feedButton at %f.\n", curX);
    curX += spacing;
    
    //Checkin button
    CCMenuItem *checkinButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"checkin_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"checkin_button_pressed.png"] target:self selector:@selector(handleButton:)];
    
    checkinButton.tag = BUTTON_CHECKIN;
    checkinButton.position = ccp(curX, 0);
    NSLog(@"Placing checkinButton at %f.\n", curX);
    curX += spacing;
    
    //map button
    CCMenuItem *mapButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"map_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"map_button_pressed.png"] target:self selector:@selector(handleButton:)];
    
    mapButton.tag = BUTTON_MAP;
    mapButton.position = ccp(curX, 0);
    NSLog(@"Placing mapButton at %f.\n", curX);
    curX += spacing;
    
    //Toilet button
    CCMenuItem *toiletButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"toilet_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"toilet_button_pressed.png"] target:self selector:@selector(handleButton:)];
    
    toiletButton.tag = BUTTON_TOILET;
    toiletButton.position = ccp(curX, 0);
    NSLog(@"Placing toiletButton at %f.\n", curX);
    curX += spacing;
    
    //Make the menu
    self.buttons = [CCMenu menuWithItems:feedButton, checkinButton, mapButton, toiletButton, nil];
    
    NSLog(@"width: %f height: %f", size.width, size.height);
    
    //self.buttons.position = CGPointMake(-.4* size.width, -.9 * size.height);
    self.buttons.position = CGPointMake(self.mySprite.position.x, -.8 * size.height);
}

-(void) refreshSpriteswithHappiness:(int)happiness andHunger:(int)hunger andBathroom:(int)bathroom
{
    //All sprite-related calculations will go here.
    [self.mySprite stopAllActions];
    
    self.idleAnimation = nil;
    self.idleAnimation = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
    
    if(happiness >= MAX_HAPPINESS/2)
    {
        for(int i = 1; i < 3; i++)
        {
            NSString * fname = [NSString stringWithFormat:@"dragon_idle_%i.png", i];
            [self.idleAnimation addFrame:[self.cache spriteFrameByName:fname]];
        }
    }
    else
    {
        //Unhappy
        for(int i = 1; i < 3; i++)
        {
            NSString * fname = [NSString stringWithFormat:@"dragon_idle_unhappy_%i.png", i];
            [self.idleAnimation addFrame:[self.cache spriteFrameByName:fname]];
        }
    }
    self.idleAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:self.idleAnimation]];
    [self.mySprite runAction:self.idleAction];
    
    [self drawPoops:bathroom];
}

-(void) drawPoops:(int)numPoops
{
    NSLog(@"Drawing %d poops.\n", numPoops);
    int i;
    for(i = 0; i < numPoops; i++)
    {
        CCSprite * tempPoop = [self.poops objectAtIndex:i];
        if(tempPoop.position.x > 2000)
        {
            //It's offscreen.  Move it on.
            int newX = 300 - (rand()%600);
            
            tempPoop.position = ccp(newX, tempPoop.position.y);
        
            CCAction * tempAction = [CCRepeatForever actionWithAction: [self.poopAction copy]];
            [tempPoop runAction:tempAction];
        }
    }
    for(i = i; i < MAX_BATHROOM; i++)
    {
        CCSprite * tempPoop = [self.poops objectAtIndex:i];
        [tempPoop stopAllActions];
        tempPoop.position = ccp(3000, tempPoop.position.y);
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
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"feed"]];
            break;
        case BUTTON_CHECKIN:
            NSLog(@"AmigoPetView::Clicked button to checkin");
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"CheckinLayer"]];
            break;
        case BUTTON_MAP:
            NSLog(@"AmigoPetView::Clicked button to see map");
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"MapLayer"]];
            break;
        case BUTTON_TOILET:
            NSLog(@"AmigoPetView::Clicked button to clean bathroom");
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"toilet"]];
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
