//
//  MapLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapLayer.h"


@implementation MapLayer
@synthesize view = view_;

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

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.view = [[AmigoMapView alloc] init];
        [self.view release];
        
        [self addChild:self.view z:HUD_LAYER];
        
	}
	return self;
}

- (void) setVisible:(BOOL)visible{
    if (visible) {
        self.view.mapview.showsUserLocation = YES;
    }
    
    [self.view.mapwrapper setVisible:visible];
    [self.view.navwrapper setVisible:visible];
    
    [super setVisible:visible];
}

- (void) dealloc {
    [view_ release];
    [super dealloc];
}
@end
