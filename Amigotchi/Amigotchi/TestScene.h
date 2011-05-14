//
//  TestScene.h
//  Amigotchi
//
//  Created by Elliott Kipper on 5/12/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PetLayer.h"
#import "CCUIViewWrapper.h"
#import "UIKit/UIKit.h"
#import <MapKit/MKMapView.h>

@interface TestScene : CCScene {
    
}
@property (nonatomic, retain) CCLayer * layer;
@property (nonatomic, retain) CCUIViewWrapper *mapwrapper;
@property (nonatomic, retain) MKMapView         *mapview;

-(void) popItLikesItsHot;

@end
