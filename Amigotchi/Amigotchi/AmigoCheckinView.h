//
//  CheckinLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCUIViewWrapper.h"
#import "CheckinDataSource.h"

@interface AmigoCheckinView : CCLayer {
    
}

@property (nonatomic, retain) CCUIViewWrapper *tablewrapper;
@property (nonatomic, retain) UITableView     *table;

@property (nonatomic, retain) CCUIViewWrapper *navwrapper;
@property (nonatomic, retain) UINavigationBar *navbar;

- (void) setupNavBar;
- (id) initWithDataSource:(CheckinDataSource *)datasource;

//need this for CCFadeIn
- (void) setOpacity:(GLubyte)thing;
@end
