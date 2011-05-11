//
//  AmigoLocationDelegate.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AmigoLocationDelegate : NSObject<CLLocationManagerDelegate> {
    
}

@property (nonatomic, retain) CLLocationManager *locManager;
@property (nonatomic, retain) CLLocation        *currLoc;
@end
