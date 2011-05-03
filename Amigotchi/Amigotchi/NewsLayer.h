//
//  NewsLayer.h
//  Amigotchi
//
//  Created by Elliott Kipper on 5/3/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "News.h"
#import "NewsView.h"

@interface NewsLayer : CCNode {
    
}

@property (nonatomic, retain) NSMutableArray * newsQueue;
@property (nonatomic, retain) NewsView * view;
@end
