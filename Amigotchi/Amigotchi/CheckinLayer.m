//
//  CheckinLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckinLayer.h"


@implementation CheckinLayer

@synthesize view = view_;
@synthesize datasource = datasource_;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	CheckinLayer *layer = [CheckinLayer node];
    
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
        
        self.datasource = [[CheckinDataSource alloc] init];
        [self.datasource release];
        
        self.view = [[AmigoCheckinView alloc] initWithDataSource:self.datasource];
        [self.view release];
        
        [self addChild:self.view z:0];
        
	}
	return self;
}

- (void) setVisible:(BOOL)visible{
    if (visible) {
        [self.view.table reloadData];
        [self.view runAction:[CCFadeIn actionWithDuration:0.1f]];
    }
    else{
        [self.view runAction:[CCFadeOut actionWithDuration:0.1f]];
    }
    
    [self.view.tablewrapper setVisible:visible];
    [self.view.navwrapper setVisible:visible];
    
    [super setVisible:visible];
}

- (void) dealloc {
    [view_ release];
    [super dealloc];
}


@end
