//
//  News.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/3/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "News.h"

@implementation News
@synthesize type = type_, myString = myString_;

-(id)initWithString:(NSString *)aString andType:(int)aType
{
    if((self = [super init]))
    {
        self.myString = aString;
        self.type = aType;
    }
    return self;
}

-(void)dealloc
{
    myString_ = nil;
    [super dealloc];
}
@end
