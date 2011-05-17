//
//  LoginView.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//changin sumthing for git


#import "LoginView.h"


@implementation LoginView
@synthesize facebookLoginButton = _facebookLoginButton, facebookLogoutButton = _facebookLogoutButton;


-(id)init
{
    if((self = [super init]))
    {
        
        [self initFacebookButtons];
    }
    return self;
}

-(void)initFacebookButtons{
    //change images
    self.facebookLoginButton = [CCMenuItemImage itemFromNormalImage:@"LoginNormal.png" selectedImage:@"LoginPressed.png" disabledImage:@"LoginPressed.png" target:self selector:@selector(facebookLoginClicked)];
    
    
    self.facebookLogoutButton = [CCMenuItemImage itemFromNormalImage:@"LogoutNormal.png" selectedImage:@"LogoutPressed.png" disabledImage:@"LogoutPressed.png" target:self selector:@selector(facebookLogoutClicked)];
    
    [self.facebookLogoutButton setVisible:NO];
    
    //add buttons to menu
    CCMenu *fbMenu = [CCMenu menuWithItems:self.facebookLoginButton, self.facebookLogoutButton, nil];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    //position menu
    fbMenu.position = ccp(size.width * .5, size.height - 3* self.facebookLoginButton.contentSize.height);
    
    [self addChild:fbMenu z:HUD_LAYER];
}

-(void)facebookLoginClicked{
    //notify
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:LOGINVIEWCHANGE object:@"facebook_login"]];
    
}

-(void)facebookLogoutClicked{
    //notify
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:LOGINVIEWCHANGE object:@"facebook_logout"]];
}

-(void)facebookLoggedIn{
    
    [self.facebookLoginButton setVisible:NO];
    [self.facebookLogoutButton setVisible:YES];
    
}
-(void)facebookLoggedOut{
    [self.facebookLoginButton setVisible:YES];
    [self.facebookLogoutButton setVisible:NO];
}

@end