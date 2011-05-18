//
//  AmigoAPI.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "AmigoUser.h"
#import "AmigoLocationDelegate.h"
#import "Facebook.h"
#import "NearbyPlacesRequestResult.h"

@interface AmigoAPI : NSObject<NearbyPlacesRequestDelegate> {
    
    
}

@property (nonatomic, readwrite, retain) ASINetworkQueue        *queue;
@property (nonatomic, readwrite, retain) AmigoUser              *user;
@property (nonatomic, retain)            AmigoLocationDelegate  *locdelegate;
@property (nonatomic, retain)            Facebook               *facebook;
@property (nonatomic, retain)            NearbyPlacesRequestResult *nearbyDelegate;


-(void)login:(NSString*)access_token;
-(void) updateNearbyPlaces;
- (void) nearbyPlacesRequestCompletedWithPlaces:(NSArray *)placesArray;
- (void) nearbyPlacesRequestFailed;
-(void)apiNotification:(NSNotification *)notification;

//helpers
- (id)parseJsonResponse:(NSString *)responseString;

@end
