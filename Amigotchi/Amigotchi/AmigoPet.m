//
//  Pet.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoPet.h"

@implementation AmigoPet
@synthesize name, type, view, age, hunger, attention, bathroom;

-(id) init
{
    if((self = [super init]))
    {
        self.type = @"dragon";
        self.view = [[AmigoPetView alloc] init];
        self.name = @"Issa";
        self.age = 0;
        self.hunger = 0;
        self.attention = MAX_ATTENTION;
        self.bathroom = 0;
        
        [self addChild:self.view];
    }
    return (self);
}

-(void)poke
{
    //Poke animation
}

-(void)feed:(int)amount
{
    self.hunger -= amount;
}

-(void) takeDump
{
    self.bathroom = 0;
}

@end
