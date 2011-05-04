//
//  MapLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapLayer.h"
#import "MapView.h"
#import "AmigoConfig.h"

@implementation MapLayer

@synthesize wrapper = wrapper_;
@synthesize mapview = mapview_;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MapLayer *layer = [MapLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	
	// return the scene
	return scene;
}

- (id) init {
    self = [super init];
    
    if(self){
        self.mapview = [[MapView alloc] init];
        [self.mapview release];
        
        
        UINavigationBar *tableViewNavigationBar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                        style:UIBarButtonSystemItemDone target:nil action:nil];
        rightButton.target = self;
        rightButton.action = @selector(done);
        
        UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
        
        item.rightBarButtonItem = rightButton;
        item.hidesBackButton = YES;
        
        [tableViewNavigationBar pushNavigationItem:item animated:NO];
        
        [item release];
        [rightButton release];
        
        [self.mapview addSubview:tableViewNavigationBar];
        [tableViewNavigationBar release];
        
        
        self.wrapper = [CCUIViewWrapper wrapperForUIView:self.mapview];
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.wrapper.contentSize = size;
        //wrapper.position = ccp(64,64);
        [self addChild:self.wrapper];
        
    }
    
    return self;
}

- (void) setVisible:(BOOL)visible{
    self.mapview.showsUserLocation = YES;
    [self.wrapper setVisible:visible];
    [super setVisible:visible];
}

- (void) dealloc {
    [mapview_ release];
    [wrapper_ release];
    [super dealloc];
}

- (void) done {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"PetLayer"]];
}


@end
