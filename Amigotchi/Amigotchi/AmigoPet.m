//
//  Pet.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoPet.h"

@implementation AmigoPet
@synthesize name, type, age, hunger, happiness, bathroom;

-(id) init
{
    if((self = [super init]))
    {
        self->type = @"dragon";
        self->name = @"Issa";
        self->happiness = MAX_HAPPINESS;
    }
    return (self);
}

-(void)feed:(int)amount
{
    self.hunger -= amount;
}

-(void) cleanBathroom
{
    self.bathroom = 0;
}

@end
