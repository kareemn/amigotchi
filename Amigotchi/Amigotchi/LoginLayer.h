//
//  FacebookLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FBConnect.h"
#import "AmigoAPI.h"
#import "AmigoConfig.h"

@interface LoginLayer : CCLayer<FBSessionDelegate> {
    Facebook            *facebook;
    NSArray             *permissions;
    
    BOOL                isFBLogged;
    
    CCMenuItem          *facebookLoginButton;
    CCMenuItem          *facebookLogoutButton;
    
    //amigo stuff
    AmigoAPI            *api;
    AmigoUser           *user;
}

@property (nonatomic, readwrite, retain) Facebook *facebook;
@property (nonatomic, readwrite, retain) NSArray  *permissions;
@property (nonatomic, readwrite, retain) AmigoAPI *api;

// returns a CCScene that contains the FacebookLayer as the only child
+(CCScene *) scene;

-(void)initApi;
-(void)initFacebookButtons;
-(void)facebookLogin;

@end
