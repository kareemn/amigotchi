//
//  PetLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PetLayer.h"


@implementation PetLayer
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
        
        // add device dressing
        CCSprite * screen = [[CCSprite alloc] initWithFile:@"screen.png"];
        screen.position = ccp(size.width/2, size.height - MENU_HEIGHT - screen.contentSize.height/2);
        [self addChild:screen z:DEVICE_LAYER];
        
        // add a dragon
        AmigoPet * dragon = [[AmigoPet alloc] init];
        dragon.scale = .5;
        dragon.position = ccp(size.width/2, size.height - MENU_HEIGHT - screen.contentSize.height/2);
        [self addChild:dragon z:PET_LAYER];
        
        
	}
	return self;
}
@end
