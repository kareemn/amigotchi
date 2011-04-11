//
//  HelloWorldLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "FBConnect.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer<FBSessionDelegate>
{
    Facebook            *facebook;
    NSArray             *permissions;
    
    BOOL                isFBLogged;
    
    CCMenuItem          *facebookLoginButton;
    CCMenuItem          *facebookLogoutButton;
    CCLabelTTF          *message;

}

@property (nonatomic, readwrite, retain) Facebook *facebook;
@property (nonatomic, readwrite, retain) NSArray  *permissions;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)initFacebookButtons;
-(void)facebookLogin;

@end
