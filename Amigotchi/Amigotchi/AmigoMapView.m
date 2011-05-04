//
//  MapLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoMapView.h"
#import "AmigoConfig.h"

@implementation AmigoMapView

@synthesize mapwrapper = mapwrapper_;
@synthesize mapview = mapview_;
@synthesize navbar = navbar_;
@synthesize navwrapper = navwrapper_;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AmigoMapView *layer = [AmigoMapView node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	
	// return the scene
	return scene;
}

- (id) init {
    self = [super init];
    
    if(self){
        self.mapview = [[MKMapView alloc] init];
        [self.mapview release];
        
        [self setupNavbar];

        
        //[self.mapview addSubview:tableViewNavigationBar];
        //[tableViewNavigationBar release];
        
        
        self.mapwrapper = [CCUIViewWrapper wrapperForUIView:self.mapview];
        self.navwrapper = [CCUIViewWrapper wrapperForUIView:self.navbar];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.mapwrapper.contentSize = size;
        //wrapper.position = ccp(64,64);
        [self addChild:self.mapwrapper];
        [self addChild:self.navwrapper];
        
    }
    
    return self;
}

- (void) setupNavbar {
    self.navbar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    [self.navbar release];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                    style:UIBarButtonSystemItemDone target:nil action:nil];
    rightButton.target = self;
    rightButton.action = @selector(done);
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Checkout the nearby pets"];
    
    item.rightBarButtonItem = rightButton;
    item.hidesBackButton = YES;
    
    [self.navbar pushNavigationItem:item animated:NO];
    
    [item release];
    [rightButton release];
}

- (void) dealloc {
    
    [mapview_ release];
    [mapwrapper_ release];
    [navwrapper_ release];
    [super dealloc];
}

- (void) done {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"PetLayer"]];
}

- (void) setOpacity:(GLubyte)thing{
    [self.mapwrapper setOpacity:thing];
    [self.navwrapper  setOpacity:thing];
    
}



@end
