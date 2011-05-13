//
//  MapScene.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "MapScene.h"



@implementation MapScene
@synthesize layer = layer_;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.layer = [[MapLayer alloc] init];
        
	}
	return self;
}
@end
