//
//  PostCheckinRequestResult.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
@protocol PostCheckinRequestDelegate;

@interface PostCheckinRequestResult :  NSObject<FBRequestDelegate> {
    
	id<PostCheckinRequestDelegate> _postCheckinRequestDelegate;
}

- (id) initializeWithDelegate: (id)delegate;

@end

@protocol PostCheckinRequestDelegate

- (void) postCheckinRequestCompleted;
- (void) postCheckinRequestFailed;

@end