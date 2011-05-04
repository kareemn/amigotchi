//
//  NewsView.h
//  Amigotchi
//
//  Created by Elliott Kipper on 5/3/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface NewsView : CCNode {
    
}
@property (nonatomic, retain) NSString * myString;
@property (nonatomic, retain) CCSprite * mySprite;
@property (nonatomic, retain) CCSprite * newsStand;

-(id)initWithString:(NSString*)aString;
-(id)initWithString:(NSString*)aString andSprite:(CCSprite *)aSprite;
-(void)display;

@end
