//
//  HomeLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "FBConnect.h"
#import "ASIHTTPRequest.h"
#import "AmigoAPI.h"
#import "AmigoUser.h"
#import "AmigoPet.h"

#define MENU_HEIGHT 20
#define PET_LAYER 5
#define DEVICE_LAYER 3

// HomeLayer
@interface HomeLayer : CCLayer<FBSessionDelegate>
{
    Facebook            *facebook;
    NSArray             *permissions;
    
    BOOL                isFBLogged;
    
    CCMenuItem          *facebookLoginButton;
    CCMenuItem          *facebookLogoutButton;
    CCLabelTTF          *message;
    
    //amigo stuff
    AmigoAPI            *api;
    AmigoUser           *user;

}

@property (nonatomic, readwrite, retain) Facebook *facebook;
@property (nonatomic, readwrite, retain) NSArray  *permissions;
@property (nonatomic, readwrite, retain) AmigoAPI *api;

// returns a CCScene that contains the HomeLayer as the only child
+(CCScene *) scene;

-(void)initFacebookButtons;
-(void)initApi;
-(void)facebookLogin;


@end
