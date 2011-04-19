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

#define MAX_HUNGER 20
#define MAX_BATHROOM 40
#define MAX_HAPPINESS 20

@interface AmigoPet :  CCNode{
}

@property (retain, nonatomic) NSString * name;
@property (retain, nonatomic) NSString * type;

//@property (retain, nonatomic) AmigoPetView * view;

@property (readwrite, assign) int hunger;
@property (readwrite, assign) int age;
@property (readwrite, assign) int bathroom;
@property (readwrite, assign) int happiness;

- (void)poke;
- (void)feed:(int)amount;
- (void)takeDump;

@end
