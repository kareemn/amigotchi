//
//  User.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoUser.h"


@implementation AmigoUser

@synthesize name = name_, profile_id = profile_id_, access_token = access_token_;

-(NSString *)description{
    return [NSString stringWithFormat:@"AmigoUser={name: %@, profile_id: %@, access_token: %@}", self.name, self.profile_id, self.access_token];
}

- (void) dealloc {

    [name_ release];
    [profile_id_ release];
    [access_token_ release];
    
    [super dealloc];
}

@end
