//
//  HomeLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "Home.h"


// HomeLayer implementation
@implementation Home

@synthesize petlayer = petlayer_;
@synthesize maplayer = maplayer_;
@synthesize envlayer = envlayer_;
@synthesize loginlayer = loginlayer_;
@synthesize checkinlayer = checkinlayer_;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Home *layer = [Home node];
	
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
        
        LoginLayer *temploginlayer = [[LoginLayer alloc] initWithLoginDelagate:[self createLoginCallbackDelegate]];
        self.loginlayer = temploginlayer;
        
        [self addChild:self.loginlayer z:LOGIN_LAYER];
        [temploginlayer release];
        
        
        PetLayer *temppetlayer = [[PetLayer alloc] init];
        self.petlayer = temppetlayer;
        [self addChild:self.petlayer z:PET_LAYER];
        [temppetlayer release];
        
        EnvironmentLayer *tempenvLayer = [[EnvironmentLayer alloc] init];
        self.envlayer = tempenvLayer;
        
        [self addChild:self.envlayer];
        [tempenvLayer release];
        
        /*
        MapLayer *tempmaplayer = [[MapLayer alloc] init];
        self.maplayer = tempmaplayer;
        
        [self addChild:self.maplayer];
        [tempmaplayer release];
        */
        /*
        CheckinLayer *tempcheckinlayer = [[CheckinLayer alloc] init];
        self.checkinlayer = tempcheckinlayer;
        
        [self addChild:self.checkinlayer];
        [tempcheckinlayer release];
         */
         

	}
	return self;
}

- (AmigoCallbackDelegate *) createLoginCallbackDelegate {
    
    AmigoCallbackDelegate *delegate = [[[AmigoCallbackDelegate alloc] 
                                        initWithDelegate:self 
                                        andSelectorNameArray:[NSArray arrayWithObjects:@"loggedInCallback",
                                                              nil]] 
                                       autorelease];
    
    return delegate;
}


- (void) loggedInCallback {
    
    NSLog(@"HomeLayer::loggedInCallback");
}



- (void) dealloc
{
	[petlayer_ release];
    [loginlayer_ release];
    [maplayer_ release];
    [envlayer_ release];
    [checkinlayer_ release];
    
	[super dealloc];
}
@end
