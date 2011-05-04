//
//  NewsView.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/3/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "NewsView.h"
@interface NewsView()
@property (nonatomic, retain) CCLabelTTF * label;
@end

@implementation NewsView
@synthesize myString = myString_, mySprite = mySprite_;
@synthesize newsStand = newsStand_;
@synthesize label = label_;

-(id)initWithString:(NSString *)aString
{
    self = [self initWithString:aString andSprite:nil];
    return self;
}

-(id)initWithString:(NSString *)aString andSprite:(CCSprite *)aSprite
{
    if((self = [super init]))
    {
        self.mySprite = aSprite;
        self.myString = aString;
        self.newsStand = [CCSprite spriteWithFile:@"newsstand.png"];
        
        self.label = [CCLabelTTF labelWithString:self.myString fontName:@"Helvetica" fontSize:20];
        self.label.color = ccWHITE;
        self.label.position = ccp(self.newsStand.position.x,
                                  self.newsStand.position.y - self.newsStand.contentSize.height/2 + self.label.contentSize.height);
        
        [self addChild:self.newsStand];
        [self addChild:self.label];
        if(!(self.mySprite == nil))
        {
            [self addChild:self.mySprite];
        }
    }
    return self;
}

-(void) display
{
    [self runAction:[CCJumpTo actionWithDuration:2.0 position:self.position height:-30 jumps:1]];
}

-(void)dealloc
{
    newsStand_ = nil;
    mySprite_ = nil;
    myString_ = nil;
    label_ = nil;
    [super dealloc];
}
@end
