//
//  CheckinLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CheckinView.h"
#import "CCUIViewWrapper.h"

@interface CheckinDataSource : NSObject<UITableViewDataSource> {

}
@end

@interface CheckinLayer : CCLayer {
    
}

@property (nonatomic, retain) CCUIViewWrapper *wrapper;
@property (nonatomic, retain) CheckinView     *table;

@end
