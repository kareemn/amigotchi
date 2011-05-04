//
//  CheckinLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AmigoConfig.h"
#import "AmigoCheckinView.h"
#import "CheckinDataSource.h"

@interface CheckinLayer : CCLayer {
    
}


@property (nonatomic, retain) AmigoCheckinView *view;
@property (nonatomic, retain) CheckinDataSource *datasource;

@end
