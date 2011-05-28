//
//  AmigoAlertView.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/26/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "AmigoAlertView.h"


@implementation AmigoAlertView
@synthesize box = box_, label = label_, picture = picture_, myString = myString_, picturePath = picturePath_;

-(id)initWithLabel:(NSString *)labelString andPicture:(NSString *)picturePath
{
    if((self = [super init]))
    {
        self.box = [CCSprite spriteWithFile:@"amigoAlertBox.png"];
        self.box.position = ccp(-800, 0);
        //self.box.position = ccp(160, 240);
        
        self.myString = labelString;
        self.label = [CCLabelTTF labelWithString:labelString fontName:@"Helvetica" fontSize:20];
        self.label.color = ccWHITE;
        self.label.position = ccp(self.box.position.x, self.box.position.y - self.box.contentSize.height/3 - 5);
        
        self.picturePath = picturePath;
        self.picture = [CCSprite spriteWithFile:picturePath];
        self.picture.position = ccp(self.label.position.x, self.label.position.y + 10 + self.picture.contentSize.height/2);
        
        //Add children
        [self addChild:self.box];
        [self addChild:self.label];
        [self addChild:self.picture];
    }
    return self;
}

-(void)display
{
    //Handle children
    [self removeChild:self.label cleanup:YES];
    self.label = [CCLabelTTF labelWithString:self.myString fontName:@"Helvetica" fontSize:20];
    self.box.position = ccp(0,0);
    self.label.position = ccp(self.box.position.x, self.box.position.y - self.box.contentSize.height/3 - 5);
    [self addChild:self.label];
    
    [self removeChild:self.picture cleanup:YES];
    self.picture = [CCSprite spriteWithFile:self.picturePath];
    self.picture.position = ccp(self.label.position.x, self.label.position.y + 10 + self.picture.contentSize.height/2);
    [self addChild:self.picture];
    
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    id slideIn = [CCJumpTo actionWithDuration:0.0 position:ccp(size.width/2, size.height/2) height:0 jumps:1];
    id hover = [CCJumpTo actionWithDuration:1.5 position:ccp(size.width/2, size.height/2) height:0 jumps:0];
    id slideOut = [CCJumpTo actionWithDuration:0.0 position:ccp(800,800) height:0 jumps:1];
    
    CCSequence * seq = [CCSequence actionOne:slideIn two:hover];
    seq = [CCSequence actionOne:seq two:slideOut];
    
    [self runAction:seq];
}

-(void)dealloc
{
    [box_ release];
    [label_ release];
    [picture_ release];
    [myString_ release];
    [picturePath_ release];
    [super dealloc];
}
@end
