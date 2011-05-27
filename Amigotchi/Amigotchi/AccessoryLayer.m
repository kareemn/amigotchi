//
//  AccessoryLayer.m
//  Amigotchi
//
//  Created by Elliott Kipper on 4/21/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "AccessoryLayer.h"


@implementation AccessoryLayer
@synthesize model = model_, view = view_;

- (void) dealloc {
    [model_ release];
    [view_ release];
    
    [super dealloc];
}

@end
