//
//  EnvironmentLayer.m
//  Amigotchi
//
//  Created by Elliott Kipper on 4/19/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "EnvironmentLayer.h"


@implementation EnvironmentLayer
@synthesize view = view_, model = model_;

- (id) init
{
    if((self = [super init]))
    {
        self.view = [[EnvironmentView alloc] init];
        [self addChild:self.view];
    }
    return (self);
}

- (void) dealloc {
    [view_ release];
    [model_ release];
    
    [super dealloc];
}

@end
