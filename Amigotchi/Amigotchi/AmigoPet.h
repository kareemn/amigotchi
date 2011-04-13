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
#import "Accessory.h"
#import "AmigoPetView.h"

@interface AmigoPet :  CCNode<CCTargetedTouchDelegate>{
    //HomeLayer * theGame;
    
    CCSprite        * mySprite;
    
    Accessory        * acc1;
    Accessory        * acc2;
    
    NSString        * name;
    NSString        * type;
    
    int             hunger;
    int             attention;
    int             health;
    int             age;
    int             strength;
    int             bathroom;
    
    AmigoPetView *  view;  //Replace mySprite with this
    
}

//@property (retain, nonatomic) HomeLayer * theGame;
@property (retain, nonatomic) CCSprite * mySprite;
@property (retain, nonatomic) NSString * type;

-(void)setSpritesForType:(NSString*)type;
-(void)poke;

@end
