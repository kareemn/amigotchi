//
//  PostCheckinRequestResult.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "PostCheckinRequestResult.h"

@implementation PostCheckinRequestResult

- (id) initializeWithDelegate:(id )delegate {
    
	self = [super init];
	_postCheckinRequestDelegate = [delegate retain];
    
	return self;
}

/**
 * FBRequestDelegate
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    
	[_postCheckinRequestDelegate postCheckinRequestCompleted];
}

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error {
    
	NSLog(@"Post Checkin Failed:%@", [error localizedDescription]);
    
	[_postCheckinRequestDelegate postCheckinRequestFailed];
}

@end