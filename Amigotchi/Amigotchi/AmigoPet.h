//
//  Pet.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Accessory.h"
#import "AmigoConfig.h"

@interface AmigoPet :  CCNode{
}

@property (retain, nonatomic) NSString * name;
@property (retain, nonatomic) NSString * type;


@property (readwrite, assign) int hunger;
@property (readwrite, assign) int age;
@property (readwrite, assign) int bathroom;
@property (readwrite, assign) int happiness;

- (id) initWithDictionary:(NSDictionary*)dict;
- (void)feed:(int)amount;
- (void)updateHappiness:(int)amount;
- (void)updateBathroom:(int)amount;
- (void)cleanBathroom;
- (void)step:(ccTime*)dt;

- (NSDictionary*)currentState;

@end
