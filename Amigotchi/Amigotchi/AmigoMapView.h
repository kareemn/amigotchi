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
#import "UIKit/UIKit.h"
#import <MapKit/MKMapView.h>

@interface AmigoMapView : CCNode {
    
}
- (void) setupNavbar;

@property (nonatomic, retain) CCUIViewWrapper *mapwrapper;
@property (nonatomic, retain) MKMapView         *mapview;

@property (nonatomic, retain) CCUIViewWrapper *navwrapper;
@property (nonatomic, retain) UINavigationBar *navbar;

+(CCScene *) scene;
- (void) setOpacity:(GLubyte)thing;



@end
