//
//  LoginView.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FBConnect.h"
#import "AmigoConfig.h"


@interface LoginView : CCNode {
    
}
@property (nonatomic, retain) CCMenuItem    *facebookLoginButton;
@property (nonatomic, retain) CCMenuItem    *facebookLogoutButton;
@property (nonatomic, retain) CCMenuItem    *howToButton;

-(void)initFacebookButtons;

-(void)facebookLoginClicked;
-(void)facebookLogoutClicked;

-(void)facebookLoggedIn;
-(void)facebookLoggedOut;

-(void)showHowTo;
@end