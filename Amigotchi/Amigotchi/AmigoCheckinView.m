//
//  CheckinLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoCheckinView.h"
#import "AmigoConfig.h"

@implementation AmigoCheckinView

@synthesize tablewrapper = tablewrapper_;
@synthesize table = table_;

@synthesize navwrapper = navwrapper_;
@synthesize navbar = navbar_;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AmigoCheckinView *layer = [AmigoCheckinView node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

- (id) init {
    self = [super init];
    
    if(self){
        self.table = [[UITableView alloc] init];
        [self.table release];
        
        [self setupNavBar];
        
        self.tablewrapper = [CCUIViewWrapper wrapperForUIView:self.table];
        self.navwrapper = [CCUIViewWrapper wrapperForUIView:self.navbar];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.tablewrapper.contentSize = size;
        
        //wrapper.position = ccp(64,64);
        [self addChild:self.tablewrapper];
        [self addChild:self.navwrapper];
        
    }
    
    return self;
}

- (id) initWithDataSource:(CheckinDataSource *)datasource{
    self = [self init];
    
    if (self != nil){
        self.table.dataSource = datasource;
    }
    
    return self;
}

- (void) setupNavBar{
    self.navbar = [[UINavigationBar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                    style:UIBarButtonSystemItemDone target:nil action:nil];
    rightButton.target = self;
    rightButton.action = @selector(done);
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
    
    item.rightBarButtonItem = rightButton;
    item.hidesBackButton = YES;
    
    [self.navbar pushNavigationItem:item animated:NO];
    
    [item release];
    [rightButton release];
}

- (void) dealloc {
    [table_ release];
    [tablewrapper_ release];
    [navbar_ release];
    [navwrapper_ release];
    
    [super dealloc];
}

- (void) done {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"PetLayer"]];
}


@end
