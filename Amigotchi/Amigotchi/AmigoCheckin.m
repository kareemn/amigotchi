//
//  AmigoCheckin.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoCheckin.h"


@implementation AmigoCheckin

@synthesize title = title_;
@synthesize place_id = place_id_;
@synthesize lon = lon_;
@synthesize lat = lat_;

- (void) dealloc {
    [title_ release];
    [place_id_ release];
    [lon_ release];
    [lat_ release];
    
    [super dealloc];
}

@end
