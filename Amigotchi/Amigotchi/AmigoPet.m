//
//  Pet.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoPet.h"

@implementation AmigoPet
@synthesize name, type, view;

-(id) init
{
    if((self = [super init]))
    {
        self.type = @"dragon";
        self.view = [[AmigoPetView alloc] init];
        
        self.name = @"Putnam";
        
        [self addChild:self.view];
    }
    return (self);
}

-(void)poke
{
    //Poke animation
}

@end
