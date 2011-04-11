//
//  Pet.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldLayer.h"

@interface AmigoPet :  CCNode{
    //HelloWorldLayer * theGame;
    
    CCSprite        * mySprite;
    
    NSString        * name;
    
    int             hunger;
    int             attention;
    int             health;
    int             age;
    int             strength;
    int             bathroom;
    
}

//@property (retain, nonatomic) HelloWorldLayer * theGame;
@property (retain, nonatomic) CCSprite * mySprite;

//-(id)initWithGame:(HelloWorldLayer *)game;

@end
