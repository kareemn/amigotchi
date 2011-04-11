//
//  User.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoUser.h"


@implementation AmigoUser

@synthesize name, profile_id, access_token;

-(NSString *)description{
    return [NSString stringWithFormat:@"AmigoUser={name: %@, profile_id: %@, access_token: %@}", name, profile_id, access_token];
}

@end
