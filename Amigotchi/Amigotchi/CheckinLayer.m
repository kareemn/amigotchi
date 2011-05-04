//
//  CheckinLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckinLayer.h"
#import "AmigoConfig.h"

@implementation CheckinLayer

@synthesize wrapper = wrapper_;
@synthesize table = table_;
@synthesize datasource = datasource_;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CheckinLayer *layer = [CheckinLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

- (id) init {
    self = [super init];
    
    if(self){
        
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
        
        self.table = [[CheckinView alloc] init];
        [self.table release];
        [self.table addSubview:tableViewNavigationBar];
        [tableViewNavigationBar release];
        
        self.datasource = [[CheckinDataSource alloc ] init];
        [self.datasource release];
        
        //set the data source
        self.table.dataSource = self.datasource;
        
        
        self.wrapper = [CCUIViewWrapper wrapperForUIView:self.table];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.wrapper.contentSize = size;
        
        //wrapper.position = ccp(64,64);
        [self addChild:self.wrapper];
        
    }
    
    return self;
}

- (void) setVisible:(BOOL)visible{
    [self.table reloadData];
    [self.wrapper setVisible:visible];
    [super setVisible:visible];
}

- (void) dealloc {
    [table_ release];
    [datasource_ release];
    [wrapper_ release];
    [super dealloc];
}

- (void) done {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"PetLayer"]];
}


@end
