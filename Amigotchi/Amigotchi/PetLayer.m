//
//  PetLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PetLayer.h"


@implementation PetLayer
@synthesize pet = _pet, view = _view;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PetLayer *layer = [PetLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize]; 
        
        // add a pet model
        self.pet = [[AmigoPet alloc] init];
        
        [self.pet addObserver:self forKeyPath:@"bathroom" options:(NSKeyValueObservingOptionNew |
                                                         NSKeyValueObservingOptionInitial) context:nil];
        [self.pet addObserver:self forKeyPath:@"happiness" options:(NSKeyValueObservingOptionNew |
                                                                   NSKeyValueObservingOptionInitial) context:nil];
        [self.pet addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionNew |
                                                                    NSKeyValueObservingOptionInitial) context:nil];
        [self.pet addObserver:self forKeyPath:@"hunger" options:(NSKeyValueObservingOptionNew |
                                                                    NSKeyValueObservingOptionInitial) context:nil];
        
        //add a pet view
        self.view = [[AmigoPetView alloc] initWithCallbackDelegate:[self createCallbackDelegate]];
        self.view.scale = .5;
        self.view.position = ccp(size.width/2, size.height - MENU_HEIGHT - self.view.mySprite.contentSize.height/2);
        [self addChild:self.view z:PET_LAYER];
        
        //listen for notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputFromView:) name:PETVIEWCHANGE object:nil];
        
        
	}
	return self;
}

-(void)inputFromView:(NSNotification *)notification{
    
   // NSLog([[notification userInfo] description]);
    //NSLog([[notification object] description]);
    NSLog(@"inputFromView:: received %@.\n", [notification object]);
    if([[notification object] isEqualToString:@"poke"])
    {
        self.pet.happiness--;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keypath is: %@", keyPath);
    NSLog(@"object is: %@", [object description]);
    NSLog(@"change is: %@", [change description]);
    [self.view refreshSpriteswithHappiness:self.pet.happiness andHunger:self.pet.hunger andBathroom:self.pet.bathroom];
}

-(void)happinessClicked:(int)butt
{
    self.pet.happiness += butt;
}

-(void)feedClicked:(int)balls
{
    self.pet.hunger += balls;
}

- (AmigoCallbackDelegate *) createCallbackDelegate {
    AmigoCallbackDelegate *delegate = [[[AmigoCallbackDelegate alloc] 
                                                initWithDelegate:self 
                                                andSelectorNameArray:[NSArray arrayWithObjects:@"foodButtonCallback",
                                                                                               @"checkinButtonCallback",
                                                                                               @"mapButtonCallback" , nil]] 
                                       autorelease];
    
    return delegate;
}


- (void) foodButtonCallback {
    NSLog(@"PetLayer::foodButtonCallback");
}
- (void) checkinButtonCallback {
    NSLog(@"PetLayer::checkinButtonCallback");
    
}
- (void) mapButtonCallback {
    NSLog(@"PetLayer::mapButtonCallback");
    
}
         
@end
