//
//  FacebookLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginLayer.h"


@implementation LoginLayer

@synthesize facebook = _facebook, isFBLogged = _isFBLogged, permissions = _permissions, api = _api, user = _user, view = _view;

@synthesize loginDelegate = loginDelegate_;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	LoginLayer *layer = [LoginLayer node];
    
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
        
        [self initNotifiation];
        self.view = [[LoginView alloc] init];
        [self addChild:self.view z:HUD_LAYER];
        
	}
	return self;
}

-(id) initWithAmigoAPI: (AmigoAPI *)a{
    self = [self init];
    
    if(self){
        self.api = a;
    }
    
    return self;
}


-(void)initNotifiation {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputFromView:) name:LOGINVIEWCHANGE object:nil];
}

-(void)inputFromView:(NSNotification *)notification{
    if([[notification object] isEqualToString:@"facebook_login"])
    {
        [self facebookLogin];
    }
    else if( [[notification object] isEqualToString:@"facebook_logout"] ){
        [self facebookLogout];
    }
}


-(void)facebookLogin{
    if (self.facebook == nil){
        self.facebook = [[Facebook alloc] initWithAppId:kAppId];
        self.api.facebook = self.facebook;
    }
    
    self.permissions =  [[NSArray arrayWithObjects:
                          @"offline_access", @"user_checkins", @"publish_checkins",nil] retain];
    
    [self.facebook authorize:self.permissions delegate:self];
    
}

-(void)facebookLogout{
    [self.facebook logout:self];
    
}

/* automatically called when facebook authorize delegate:self is successful */
- (void)fbDidLogin {
    self.isFBLogged = YES;
    NSLog(@"Login successful");
    
    [self.api login:[self.facebook accessToken]];
    
    if(self.user == nil){
        self.user = [[AmigoUser alloc] init];
    }
    
    [self.view facebookLoggedIn];
    
    /* to add more callbacks to the loginDelegate modify the HomeLayer createLoginCallbackDelegate */
}


/* automatically called when faecbook authorize is cancelled/failed */
-(void)fbDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        NSLog(@"Login cancelled :)");
    } else {
        NSLog(@"Error. Please try again.");
    }
}

-(void)fbDidLogout{
    NSLog(@"Logout successful");
    
    [self.view facebookLoggedOut];
    
}


@end
