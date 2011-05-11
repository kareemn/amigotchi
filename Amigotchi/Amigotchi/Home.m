//
//  HomeLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "Home.h"


// HomeLayer implementation
@implementation Home

@synthesize petlayer = petlayer_;
@synthesize maplayer = maplayer_;
@synthesize envlayer = envlayer_;
@synthesize loginlayer = loginlayer_;
@synthesize checkinlayer = checkinlayer_;
@synthesize newsLayer = newsLayer_;
@synthesize locDelegate = locDelegate_;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Home *layer = [Home node];
	
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
        //listen for notifications
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateNotification:) name:AMIGONAVNOTIFICATION object:nil];
        
        self.locDelegate = [[[AmigoLocationDelegate alloc] init] autorelease];
        
        LoginLayer *temploginlayer = [[LoginLayer alloc] initWithLoginDelagate:[self createLoginCallbackDelegate]];
        self.loginlayer = temploginlayer;
        [temploginlayer release];
        
        
        PetLayer *temppetlayer = [[PetLayer alloc] init];
        self.petlayer = temppetlayer;
        [temppetlayer release];
        
        EnvironmentLayer *tempenvLayer = [[EnvironmentLayer alloc] init];
        self.envlayer = tempenvLayer;
        [tempenvLayer release];
        
        MapLayer *tempmaplayer = [[MapLayer alloc] init];
        self.maplayer = tempmaplayer;
        [tempmaplayer release];

        CheckinLayer *tempcheckinlayer = [[CheckinLayer alloc] init];
        self.checkinlayer = tempcheckinlayer;
        [tempcheckinlayer release];
        
        NewsLayer * tempnewslayer = [[NewsLayer alloc] init];
        self.newsLayer = tempnewslayer;
        [tempnewslayer release];
        
        
        [self addChild:self.loginlayer z:LOGIN_LAYER];
        [self addChild:self.petlayer z:PET_LAYER];
        [self addChild:self.envlayer];
        [self addChild:self.maplayer];
        [self addChild:self.checkinlayer];
        [self addChild:self.newsLayer z:HUD_LAYER];

        [self showLoginScreen];
        
	}
	return self;
}

- (AmigoCallbackDelegate *) createLoginCallbackDelegate {
    
    AmigoCallbackDelegate *delegate = [[[AmigoCallbackDelegate alloc] 
                                        initWithDelegate:self 
                                        andSelectorNameArray:[NSArray arrayWithObjects:@"loggedInCallback",
                                                              nil]] 
                                       autorelease];
    
    return delegate;
}

-(void)navigateNotification:(NSNotification *)notification{
    
    // NSLog([[notification userInfo] description]);
    //NSLog([[notification object] description]);
    //NSLog(@"inputFromView:: received %@.\n", [notification object]);
    
    NSString *theobj = [notification object];
    
    if([theobj isEqualToString:@"MapLayer"])
    {
        NSLog(@"navigateNotification::show map layer clicked");
        [self showMapScreen];
    }
    else if ( [theobj isEqualToString:@"CheckinLayer"] ){
        NSLog(@"navigateNotification::show checkin layer clicked");
        [self showCheckinScreen];
    }
    else if( [theobj isEqualToString:@"toilet"] ) {
        NSLog(@"navigateNotification::toilet clicked");
        [self.petlayer.pet updateBathroom:-1];
    }
    else if( [theobj isEqualToString:@"PetLayer"] ) {
        NSLog(@"navigateNotification::petlayer clicked");
        [self showPetScreen];
    }
    else if( [theobj isEqualToString:@"feed"] ) {
        NSLog(@"navigateNotification::feed clicked");
        [self.petlayer.pet feed:1];
        
    }
    else 
    {
        [self.newsLayer newsWithString:theobj];
    }
}

- (void) showLoginScreen {
    NSLog(@"Home::showLoginScreen");
    
    [self.loginlayer setVisible:YES];
    [self.petlayer setVisible:NO];
    [self.envlayer setVisible:NO];
    [self.maplayer setVisible:NO];
    [self.checkinlayer setVisible:NO];
    [self.newsLayer setVisible:NO];
    
    

}

- (void) showPetScreen {
    NSLog(@"Home::showPetScreen");
    [self.loginlayer setVisible:NO];
    [self.petlayer setVisible:YES];
    [self.envlayer setVisible:YES];
    [self.maplayer setVisible:NO];
    [self.checkinlayer setVisible:NO];
    [self.newsLayer setVisible:YES];
    
    
}
- (void) showMapScreen {
    NSLog(@"Home::showMapScreen");
    [self.loginlayer setVisible:NO];
    [self.petlayer setVisible:NO];
    [self.envlayer setVisible:NO];
    [self.maplayer setVisible:YES];
    [self.checkinlayer setVisible:NO];
    [self.newsLayer setVisible:NO];
}
- (void) showCheckinScreen {
    NSLog(@"Home::showCheckinScreen");
    [self.loginlayer setVisible:NO];
    [self.petlayer setVisible:NO];
    [self.envlayer setVisible:NO];
    [self.maplayer setVisible:NO];
    [self.checkinlayer setVisible:YES];
    [self.newsLayer setVisible:NO];
}
- (void) showFoodScreen {
    NSLog(@"Home::showFoodScreen");
    
}

- (void) loggedInCallback {
    
    NSLog(@"HomeLayer::loggedInCallback");
    [self showPetScreen];
    [self.newsLayer newsWithString:@"Welcome back!"];
    [[CCScheduler sharedScheduler] scheduleSelector:@selector(step:) forTarget:self.petlayer.pet interval:4.0f paused:NO];
}



- (void) dealloc
{
	[petlayer_ release];
    [loginlayer_ release];
    [maplayer_ release];
    [envlayer_ release];
    [checkinlayer_ release];
    [newsLayer_ release];
    [locDelegate_ release];
    
	[super dealloc];
}
@end
