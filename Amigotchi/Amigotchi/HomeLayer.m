//
//  HelloWorldLayer.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

static NSString* kAppId = @"196872950351792";

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize facebook, permissions ,api;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
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
        
		
		// create and initialize a Label
		message = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:32];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		message.position =  ccp( size.width /2 , size.height/2 + size.height/3 );
		
		// add the label as a child to this Layer
		[self addChild: message];
        [self initApi];
        [self initFacebookButtons];
        
        AmigoPet * dragon = [[AmigoPet alloc] init];
        dragon.position = ccp(100, 100);
        [self addChild:dragon z:10];
        

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
    fbMenu.position = ccp(size.width * .5, size.height * .75 + facebookLoginButton.contentSize.height * 3);
    
    [self addChild:fbMenu];
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
    [message setString:@"Login successful"];
    
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
        [message setString:@"Login cancelled :)"];
    } else {
        [message setString:@"Error. Please try again."];
    }
}

-(void)fbDidLogout{
    [message setString:@"Logout successful"];
    
    [facebookLoginButton setVisible:YES];
    [facebookLogoutButton setVisible:NO];
}

-(void)updateUserLabel:(NSString*)name{
    [message setString:[NSString stringWithFormat:@"Hello %@", name]];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
