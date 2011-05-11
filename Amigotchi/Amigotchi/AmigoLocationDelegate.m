//
//  AmigoLocationDelegate.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoLocationDelegate.h"


@implementation AmigoLocationDelegate
@synthesize locManager = locManager_;
@synthesize currLoc = currLoc_;

- (id)init {
	self = [super init];
    
	if(self != nil) {
		self.locManager = [[[CLLocationManager alloc] init] autorelease];
		self.locManager.delegate = self; 
	}
    
	return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"updated location");
    self.currLoc = newLocation;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    return;
}

- (void) dealloc {
    
    [locManager_ release];
    [currLoc_ release];
    [super dealloc];
}

@end
