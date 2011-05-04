//
//  News.h
//  Amigotchi
//
//  Created by Elliott Kipper on 5/3/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface News : CCNode {
    
}

@property (nonatomic, retain) NSString * myString;
@property int type;

-(id)initWithString:(NSString*)aString andType:(int)aType;
@end
