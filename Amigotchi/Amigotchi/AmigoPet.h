//
//  Pet.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AmigoPet :  CCNode{
    CCSprite        *bodySprite;
    CCSprite        *headSprite;
    CCSprite        *limbSprite;
    
    NSString        *name;
    
    int             hunger;
    int             attention;
    int             health;
    int             age;
    int             strength;
    int             bathroom;
    
}

@end
