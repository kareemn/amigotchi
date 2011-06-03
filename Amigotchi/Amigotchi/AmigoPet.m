//
//  Pet.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoPet.h"
#import "AppDelegate.h"

@implementation AmigoPet
@synthesize name = name_, type = type_, age = age_, hunger = hunger_, happiness = happiness_, bathroom = bathroom_;
@synthesize accessory = accessory_;

-(id) init
{
    if((self = [super init]))
    {
        self.type = @"dragon";
        self.name = @"Issa";
        self.happiness = MAX_HAPPINESS;
        self.accessory = @"none";
        
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.api.pet = self;
    }
    return (self);
}

-(void)feed:(int)amount
{
    //Setup variables
    BOOL wasHungry = NO;
    BOOL isHungry = NO;
    if(self.hunger >= MAX_HUNGER/2)
        wasHungry = YES;
    
    if(self.hunger - amount < 0)
        self.hunger = 0;
    else if(self.hunger - amount > MAX_HUNGER)
        self.hunger = MAX_HUNGER;
    else
        self.hunger -= amount;
    
    //Check state changes
    if(self.hunger >= MAX_HUNGER/2)
        isHungry = YES;
    
    //Send news
    if(wasHungry == NO && isHungry == YES)
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"I'm getting hungry."]];
    if(self.hunger == MAX_HUNGER)
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"I'm starving!"]];
    else if(self.hunger == 0)
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"I'm full!"]];
    //else if(amount > 0)
        //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"Yummy!"]];
}

-(void)updateBathroom:(int)amount
{
    //Setup variables
    BOOL wasTooMuchPoop = NO;
    BOOL isTooMuchPoop = NO;
    if(self.bathroom >= MAX_BATHROOM/2)
        wasTooMuchPoop = YES;
    
    //Max and min checks
    if(self.bathroom + amount > MAX_BATHROOM)
        self.bathroom = MAX_BATHROOM;
    else if(self.bathroom + amount < 0)
        self.bathroom = 0;
    else
        self.bathroom += amount;
    
    //Check state changes
    if(self.bathroom >= MAX_BATHROOM/2)
        isTooMuchPoop = YES;
    
    //Send news
    if(wasTooMuchPoop == NO && isTooMuchPoop == YES)
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"Clean my poop!"]];
    else if(self.bathroom == 0)
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"All clean!"]];
}

-(void)updateHappiness:(int)amount
{
    //Setup variables
    BOOL wasHappy = NO;
    BOOL isHappy = NO;
    if(self.happiness >= MAX_HAPPINESS/2)
        wasHappy = YES;
    
    //Max and min checks
    if(self.happiness + amount > MAX_HAPPINESS)
        self.happiness = MAX_HAPPINESS;
    else if(self.happiness + amount < 0)
        self.happiness = 0;
    else
        self.happiness += amount;
    
    //Check state changes
    if(self.happiness >= MAX_HAPPINESS/2)
        isHappy = YES;
    
    //Send news
    if(wasHappy == YES && isHappy == NO)
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"I'm upset."]];
    if(wasHappy == NO && isHappy == YES)
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"(^-^)"]];
}

-(void) cleanBathroom
{
    self.bathroom = 0;
}

-(void) step:(ccTime *)dt
{
    NSLog(@"AmigoPet::step: Updating!\n");
    /*
    [self updateBathroom:1];
    [self updateHappiness:(0 - (self.bathroom/3) - 1)];
    [self feed:-1];
     */
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.api petLoad];

}

-(NSDictionary*)currentState
{
    NSArray * keys = [NSArray arrayWithObjects:@"name", @"type", @"age", @"hunger", @"happiness", @"bathroom", @"accessory", nil];
    NSArray * objects = [NSArray arrayWithObjects:
                         self.name,
                         self.type,
                         [NSNumber numberWithInt:self.age],
                         [NSNumber numberWithInt:self.hunger],
                         [NSNumber numberWithInt:self.happiness],
                         [NSNumber numberWithInt:self.bathroom],
                         self.accessory,
                         nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    return dictionary;
}

-(void)restoreState:(NSDictionary *)dict
{
    self.type = [dict objectForKey:@"type"];
    self.name = [dict objectForKey:@"name"];
    
    if ([[dict objectForKey:@"age"] isKindOfClass:[NSNull class]] || [dict objectForKey:@"age"]==nil) {
        self.age = 0;
    }
    else {
       self.age = [[dict objectForKey:@"age"]intValue];
    }
    
    if ([[dict objectForKey:@"hunger"] isKindOfClass:[NSNull class]] || [dict objectForKey:@"hunger"]==nil ) {
        self.hunger = 0;
    }
    else {
        self.hunger = [[dict objectForKey:@"hunger"]intValue];
    }
    
    
    if ([[dict objectForKey:@"happiness"] isKindOfClass:[NSNull class]] || [dict objectForKey:@"happiness"]==nil) {
        self.happiness = 0;
    }
    else {
        self.happiness = [[dict objectForKey:@"happiness"]intValue];
    }
    
    if ([[dict objectForKey:@"bathroom"] isKindOfClass:[NSNull class]] || [dict objectForKey:@"bathroom"]==nil) {
        self.bathroom = 0;
    }
    else {
        self.bathroom = [[dict objectForKey:@"bathroom"]intValue];
    }
    
    
    if ([dict objectForKey:@"accessory"]==nil || [[dict objectForKey:@"accessory"] isKindOfClass:[NSNull class]] || 
        ![[dict objectForKey:@"accessory"] isKindOfClass:[NSString class]] ) {
        self.accessory = @"none";
    }
    else {
        
        self.accessory = [dict objectForKey:@"accessory"];
    }
    
}

@end
