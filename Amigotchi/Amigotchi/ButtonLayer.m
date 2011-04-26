//
//  ButtonLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ButtonLayer.h"
#import "AmigoConfig.h"

@implementation ButtonLayer

@synthesize credits = _credits;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	ButtonLayer *layer = [ButtonLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
    
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.credits = [CCMenuItemImage itemFromNormalImage:@"LoginNormal.png" selectedImage:@"LoginPressed.png" disabledImage:@"LoginPressed.png" target:self selector:@selector(creditsButtonClicked)];
        
        
        //add buttons to menu
        CCMenu *fbMenu = [CCMenu menuWithItems:self.credits, nil];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //position menu
        fbMenu.position = ccp(size.width * .5, size.height - self.credits.contentSize.height);
        
        [self addChild:fbMenu z:HUD_LAYER];
    
	}
	return self;
}

-(void)creditsButtonClicked{
    NSLog(@"button clicked");
}


@end
