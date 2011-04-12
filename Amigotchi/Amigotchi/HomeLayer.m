//
//  HomeLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HomeLayer.h"
#import "PetLayer.h"
#import "LoginLayer.h"

// HomeLayer implementation
@implementation HomeLayer



+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HomeLayer *layer = [HomeLayer node];
	
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
        
        LoginLayer *loginlayer = [[LoginLayer alloc] init];
        [self addChild:loginlayer z:LOGIN_LAYER];
        
        PetLayer *petlayer = [[PetLayer alloc] init];
        [self addChild:petlayer z:PET_LAYER];
        

	}
	return self;
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
