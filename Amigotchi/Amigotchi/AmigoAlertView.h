//
//  AmigoAlertView.h
//  Amigotchi
//
//  Created by Elliott Kipper on 5/26/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AmigoAlertView : CCNode {
    
}

@property (nonatomic, retain) CCSprite * box;
@property (nonatomic, retain) CCSprite * picture;
@property (nonatomic, retain) CCLabelTTF * label;

-(id) initWithLabel:(NSString*)labelString andPicture:(NSString*)picturePath;
-(void) display;
@end
