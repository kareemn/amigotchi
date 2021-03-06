//
//  AmigoPetView.m
//  Amigotchi
//
//  Created by Elliott Kipper on 4/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "AmigoPetView.h"
#import "AppDelegate.h"

@interface AmigoPetView()

@property (nonatomic, retain) CCAnimation * poopAnimation;
@property (nonatomic, retain) CCAction * poopAction;
@property (nonatomic, retain) CCSprite * hungerBarContainer;
@property (nonatomic, retain) CCSprite * happinessBarContainer;

@end

@implementation AmigoPetView
@synthesize mySprite = mySprite_, idleAnimation = idleAnimation_, pokeAnimation = pokeAnimation_;
@synthesize cache=cache_, pokeAction = pokeAction_, idleAction = idleAction_;
@synthesize buttons = buttons_;
@synthesize poops = poops_;
@synthesize poopAnimation = poopAnimation_, poopAction = poopAction_;
@synthesize happinessBar = happinessBar_, hungerBar = hungerBar_;
@synthesize happinessBarContainer = happinessBarContainer_, hungerBarContainer = hungerBarContainer_;
@synthesize accessory = accessory_;

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
        self.accessory = [CCSprite spriteWithFile:@"cowboy_hat.png"];
        self.accessory.visible = NO;
        self.accessory.position = ccp(self.mySprite.position.x + self.mySprite.contentSize.width/2,
                                      self.mySprite.position.y + self.mySprite.contentSize.height * .95);
        
        [self.mySprite addChild:self.accessory];
        [self.mySprite runAction:self.idleAction];
        [self addChild:self.mySprite];
        [self addChild:self.buttons];
        [self addChild:self.hungerBarContainer];
        [self addChild:self.happinessBarContainer];
        [self addChild:self.happinessBar];
        [self addChild:self.hungerBar];
    }
    return self;
}

-(id)initWithHappiness:(int)happiness andHunger:(int)hunger andBathroom:(int)bathroom andAge:(int)age andAccessory:(NSString *)acc
{
    if((self = [super init]))
    {
        [self init];
        [self refreshSpriteswithHappiness:happiness andHunger:hunger andBathroom:bathroom andAge:age andAccessory:acc];
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
    
    
    //Bars
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    self.happinessBar = [CCSprite spriteWithFile:@"happiness_bar.png"];
    self.happinessBar.position = ccp(0 - 300, size.height * 0.96);
    self.happinessBar.anchorPoint = ccp(0,1);
    self.happinessBarContainer = [CCSprite spriteWithFile:@"happiness_bar_container.png"];
    self.happinessBarContainer.position = ccp(0, self.happinessBar.position.y - self.happinessBar.contentSize.height/2);
    
    self.hungerBar = [CCSprite spriteWithFile:@"hunger_bar.png"];
    self.hungerBar.position = ccp(0 - 300, self.happinessBar.position.y - self.happinessBarContainer.contentSize.height * 1.1);
    self.hungerBar.anchorPoint = ccp(0,1);
    self.hungerBarContainer = [CCSprite spriteWithFile:@"hunger_bar_container.png"];
    self.hungerBarContainer.position = ccp(0, self.hungerBar.position.y - self.hungerBar.contentSize.height/2);

}

-(void) setButtons
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    [self.cache addSpriteFramesWithFile:@"buttons.plist"];
    
    //Feed button
    CCMenuItem *feedButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"feed_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"feed_button_pressed.png"] target:self selector:@selector(handleButton:)];
    
    feedButton.tag = BUTTON_FEED;
    
    //Checkin button
    CCMenuItem *checkinButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"checkin_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"checkin_button_pressed.png"] target:self selector:@selector(handleButton:)];
    
    checkinButton.tag = BUTTON_CHECKIN;
    
    //map button
    CCMenuItem *mapButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"map_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"map_button_pressed.png"] target:self selector:@selector(handleButton:)];
    
    mapButton.tag = BUTTON_MAP;
    
    //Toilet button
    CCMenuItem *toiletButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"toilet_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"toilet_button_pressed.png"] target:self selector:@selector(handleButton:)];
    
    toiletButton.tag = BUTTON_TOILET;
    
    //Info button
    CCMenuItem * infoButton = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"info_button.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"info_button_pressed.png"] target:self selector:@selector(handleButton:)];
    infoButton.tag = BUTTON_INFO;
    
    //Make the menu
    self.buttons = [CCMenu menuWithItems:feedButton, checkinButton, mapButton, toiletButton, infoButton, nil];
    
    //NSLog(@"width: %f height: %f", size.width, size.height);
    
    //self.buttons.position = CGPointMake(-.4* size.width, -.9 * size.height);
    self.buttons.position = CGPointMake(self.mySprite.position.x, -1 * size.height + toiletButton.contentSize.height/2 - 3);
    [self.buttons alignItemsHorizontallyWithPadding:0];
}

-(void) refreshSpriteswithHappiness:(int)happiness andHunger:(int)hunger andBathroom:(int)bathroom andAge:(int)age andAccessory:(NSString *)acc
{
    //All sprite-related calculations will go here.
    [self.mySprite stopAllActions];
    
    if(self.idleAnimation)
    {
        self.idleAnimation = nil;
    }
    CCAnimation * newIdle = [[CCAnimation alloc] initWithName:@"idle" delay: 1.0/2];
    self.idleAnimation = newIdle;
    [newIdle release];
    
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
    [self drawBarsHappiness:happiness Hunger:hunger];
    
    //Accessory
    
    if (acc != nil) {

        [self.mySprite removeChild:self.accessory cleanup:YES];
        self.accessory = nil;

        if([acc isEqualToString:@"cowboy hat"])
        {
            self.accessory = [CCSprite spriteWithFile:@"cowboy_hat.png"];
            self.accessory.position = ccp(self.mySprite.position.x + self.mySprite.contentSize.width/2,
                                          self.mySprite.position.y + self.mySprite.contentSize.height * .95);

            self.accessory.visible = YES;
            
        }
        else if([acc isEqualToString:@"glasses"])
        {
            self.accessory = [CCSprite spriteWithFile:@"glasses.png"];
            self.accessory.position = ccp(self.mySprite.position.x + self.mySprite.contentSize.width/2,
                                          self.mySprite.position.y + self.mySprite.contentSize.height * .7);
            self.accessory.visible = YES;
        }
        else
        {
            self.accessory = [CCSprite spriteWithFile:@"cowboy_hat.png"];
            self.accessory.visible = NO;
            
        }
        [self.mySprite addChild:self.accessory];
    }
     
    //scale it here.
    
    float newScale = 0.6 + (age/20.0);
    if(newScale > 1.2)
    {
        newScale = 1.2;
    }
    self.mySprite.scale = newScale;
}

-(void) drawPoops:(int)numPoops
{
    int i;
    for(i = 0; i < numPoops; i++)
    {
        CCSprite * tempPoop = [self.poops objectAtIndex:i];
        if(tempPoop.position.x > 2000)
        {
            //It's offscreen.  Move it on.
            int newX = 300 - (rand()%600);
            
            tempPoop.position = ccp(newX, tempPoop.position.y);
        
            CCAction * tempAction = [CCRepeatForever actionWithAction: [[self.poopAction copy]autorelease]];
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

-(void) drawBarsHappiness:(int)happiness Hunger:(int)hunger
{
    //Happiness Bar
    //self.happinessBar.position = ccp(self.mySprite.position.x, self.mySprite.position.y + self.mySprite.contentSize.height * 0.8);
    self.happinessBar.scaleX = happiness * 3.5;
    
    //Hunger Bar
    int food = MAX_HUNGER - hunger;
    //self.hungerBar.position = ccp(self.happinessBar.position.x, self.happinessBar.position.y - self.happinessBar.contentSize.height * 1.2);
    self.hungerBar.scaleX = food * 3.5;
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
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    
    switch(clickedButton.tag){
        case BUTTON_FEED:
            NSLog(@"AmigoPetView::Clicked button to feed pet");
            //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"feed"]];
            [delegate.api petFeed];
            break;
        case BUTTON_CHECKIN:
            NSLog(@"AmigoPetView::Clicked button to checkin");
            //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"CheckinLayer"]];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVCONTROLLER object:@"checkin"]];
            break;
        case BUTTON_MAP:
            NSLog(@"AmigoPetView::Clicked button to see map");
            //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"MapScene"]];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVCONTROLLER object:@"map"]];
            break;
        case BUTTON_TOILET:
            NSLog(@"AmigoPetView::Clicked button to clean bathroom");
            //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"toilet"]];
            
            [delegate.api petClean];
            break;
        case BUTTON_INFO:
            NSLog(@"AmigoPetView::Clicked button to get info");
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVCONTROLLER object:@"info"]];
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
    
    //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:PETVIEWCHANGE object:@"poke"]];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    [delegate.api petHappy];
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
    //Then release stuff
    [mySprite_ release];
    [poops_ release];
    [buttons_ release];
    [cache_ release];
    [accessory_ release];
    
    [idleAction_ release];
    [idleAnimation_ release];
    [pokeAction_ release];
    [pokeAnimation_ release];
    
    [poopAction_ release];
    [poopAnimation_ release];
    
    [happinessBar_ release];
    [hungerBar_ release];
    
    [happinessBarContainer_ release];
    [hungerBarContainer_ release];
    
    [super dealloc];
}

@end
