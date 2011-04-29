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
#import "LoginView.h"

@interface LoginLayer : CCLayer<FBSessionDelegate> {
    
    
}

@property (nonatomic, retain) Facebook      *facebook;
@property (nonatomic)         BOOL          isFBLogged;
@property (nonatomic, retain) NSArray       *permissions;
@property (nonatomic, retain) AmigoAPI      *api;
@property (nonatomic, retain) AmigoUser     *user;
@property (nonatomic, retain)  LoginView     *view;

@property (nonatomic) id            loginDelegate;
@property (nonatomic) SEL                   loginCallBack;


// returns a CCScene that contains the FacebookLayer as the only child
+(CCScene *) scene;

- (id) initWithLoginDelagate: (id)del andSelector:(SEL)loginFunc;

- (void)initApi;
- (void)initNotifiation;

- (void)facebookLogin;
- (void)facebookLogout;

@end