//
//  MapLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCUIViewWrapper.h"

@interface MapLayer : CCLayer {
    
}

@property (nonatomic, retain) CCUIViewWrapper *wrapper;

+(CCScene *) scene;



@end
