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

-(void) step:(ccTime *)dt
{
    NSLog(@"Updating!\n");
    BOOL wasHappy = NO;
    BOOL isHappy = NO;
    BOOL wasTooMuchPoop = NO;
    BOOL isTooMuchPoop = NO;
    if(self.happiness >= MAX_HAPPINESS/2)
        wasHappy = YES;
    if(self.bathroom > MAX_BATHROOM/2)
        wasTooMuchPoop = YES;
    
    if(self.hunger < MAX_HUNGER){self.hunger++;}
    if(self.happiness > 0){self.happiness--;}
    
    if(self.happiness - self.bathroom >= 0)
    {
        self.happiness -= self.bathroom;
    }
    else
    {
        self.happiness = 0;
    }
    
    if(self.bathroom < MAX_BATHROOM){self.bathroom++;}
    
    if(self.happiness >= MAX_HAPPINESS/2)
        isHappy = YES;
    if(self.bathroom >= MAX_BATHROOM/2)
        isTooMuchPoop = YES;
    
    //News stuff
    if(wasHappy == YES && isHappy == NO)
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"No longer happy."]];
    if(wasTooMuchPoop == NO && isTooMuchPoop == YES)
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"So much poop!"]];

    //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"update"]];
}

@end
