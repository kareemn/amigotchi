//
//  AmigoAlertLayer.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/26/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "AmigoAlertLayer.h"


@implementation AmigoAlertLayer
@synthesize myView = myView_;

-(id)init
{
    if((self = [super init]))
    {
        self.myView = [[AmigoAlertView alloc] initWithLabel:@"default" andPicture:@"app_icon.png"];
        [self.myView release];
        [self addChild:self.myView];
    }
    return self;
}

-(void)displayAlertWithString:(NSString *)stringLabel andPicture:(NSString *)picturePath
{
    self.myView.myString = stringLabel;
    self.myView.picturePath = picturePath;
    [self.myView display];
}

-(void)dealloc
{
    [myView_ release];
    [super dealloc];
}
@end
