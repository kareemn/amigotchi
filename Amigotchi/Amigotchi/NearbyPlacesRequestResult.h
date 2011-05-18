//
//  NearbyPlacesRequestResult.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

//NEARBY PLACES STUFF
@protocol NearbyPlacesRequestDelegate

- (void) nearbyPlacesRequestCompletedWithPlaces:(NSArray *)placesArray;
- (void) nearbyPlacesRequestFailed;

@end

@interface NearbyPlacesRequestResult : NSObject<FBRequestDelegate> {
    id<NearbyPlacesRequestDelegate> _nearbyPlacesRequestDelegate;
}

- (id) initializeWithDelegate:(id )delegate;

@end
