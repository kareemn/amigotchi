//
//  MapLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapLayer.h"
#import "MapView.h"
#import "CCUIViewWrapper.h"

@implementation MapLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MapLayer *layer = [MapLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	
	// return the scene
	return scene;
}

- (id) init {
    self = [super init];
    
    if(self){
        MapView *map = [[MapView alloc] init];
        CCUIViewWrapper *wrapper = [CCUIViewWrapper wrapperForUIView:map];
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        wrapper.contentSize = size;
        //wrapper.position = ccp(64,64);
        [self addChild:wrapper];
        
    }
    
    return self;
}

@end
