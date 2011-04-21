//
//  AccessoryLayer.h
//  Amigotchi
//
//  Created by Elliott Kipper on 4/21/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Accessory.h"
#import "AccessoryView.h"


@interface AccessoryLayer : CCNode {
    
}

@property (nonatomic, retain) Accessory * model;
@property (nonatomic, retain) AccessoryView * view;
@end
