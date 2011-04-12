//
//  Pet.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HomeLayer.h"
#import "Accesory.h"

@interface AmigoPet :  CCNode{
    //HomeLayer * theGame;
    
    CCSprite        * mySprite;
    
    Accesory        * acc1;
    Accesory        * acc2;
    
    NSString        * name;
    NSString        * type;
    
    int             hunger;
    int             attention;
    int             health;
    int             age;
    int             strength;
    int             bathroom;
    
}

//@property (retain, nonatomic) HomeLayer * theGame;
@property (retain, nonatomic) CCSprite * mySprite;
@property (retain, nonatomic) NSString * type;

-(void)setSpritesForType:(NSString*)type;

@end
