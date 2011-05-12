//
//  MapLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AmigoMapView.h"
#import "AmigoConfig.h"

@interface MapLayer : CCLayer {
    
}
+(CCScene *) scene;
@property (nonatomic, retain) AmigoMapView *view;

@end
