//
//  FacebookLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginLayer.h"


@implementation LoginLayer

@synthesize facebook, permissions ,api;

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
        
        [self initApi];
        [self initFacebookButtons];
        
	}
	return self;
}

-(void)initApi {
    api = [[AmigoAPI alloc] init];
}

-(void)initFacebookButtons{
    //change images
    facebookLoginButton = [CCMenuItemImage itemFromNormalImage:@"LoginNormal.png" selectedImage:@"LoginPressed.png" disabledImage:@"LoginPressed.png" target:self selector:@selector(facebookLogin)];
    
    
    facebookLogoutButton = [CCMenuItemImage itemFromNormalImage:@"LogoutNormal.png" selectedImage:@"LogoutPressed.png" disabledImage:@"LogoutPressed.png" target:self selector:@selector(facebookLogout)];
    
    [facebookLogoutButton setVisible:NO];
    
    //add buttons to menu
    CCMenu *fbMenu = [CCMenu menuWithItems:facebookLoginButton, facebookLogoutButton, nil];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    //position menu
    fbMenu.position = ccp(size.width * .5, size.height - facebookLoginButton.contentSize.height);
    
    [self addChild:fbMenu z:HUD_LAYER];
}

-(void)facebookLogin{
    if (facebook == nil){
        facebook = [[Facebook alloc] initWithAppId:kAppId];
    }
    
    permissions =  [[NSArray arrayWithObjects:
                     @"offline_access", @"user_checkins", @"publish_checkins",nil] retain];
    
    [facebook authorize:permissions delegate:self];
    
}

-(void)facebookLogout{
    [facebook logout:self];
    
    
}

/* automatically called when facebook authorize delegate:self is successful */
- (void)fbDidLogin {
    isFBLogged = YES;
    NSLog(@"Login successful");
    
    [api login:[facebook accessToken]];
    
    if(user == nil){
        user = [[AmigoUser alloc] init];
    }
    
    [facebookLoginButton setVisible:NO];
    [facebookLogoutButton setVisible:YES];
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
    
    [facebookLoginButton setVisible:YES];
    [facebookLogoutButton setVisible:NO];
}


@end
