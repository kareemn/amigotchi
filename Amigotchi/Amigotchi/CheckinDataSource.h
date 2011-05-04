//
//  CheckinDataSource.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CheckinDataSource : NSObject<UITableViewDataSource> {
    NSMutableArray *checkins;
}
@end
