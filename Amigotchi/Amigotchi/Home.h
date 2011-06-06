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
#import "AmigoAPI.h"
#import "AmigoUser.h"
#import "AmigoConfig.h"
#import "AmigoCallbackDelegate.h"

#import "PetLayer.h"
#import "LoginLayer.h"
#import "EnvironmentLayer.h"
#import "NewsLayer.h"
#import "AmigoLocationDelegate.h"
#import "AmigoAPI.h"
#import "AmigoAlertView.h"
#import "AmigoAlertLayer.h"
#import "SimpleAudioEngine.h"

// HomeLayer
@interface Home : CCScene
{    

}

@property (nonatomic, retain) PetLayer              *petlayer;
@property (nonatomic, retain) LoginLayer            *loginlayer;
@property (nonatomic, retain) EnvironmentLayer      *envlayer;
@property (nonatomic, retain) NewsLayer             *newsLayer;
@property (nonatomic, retain) AmigoAlertLayer       *alertLayer;
@property (nonatomic, retain) AmigoAPI              *api;
@property BOOL loggedIn;

// returns a CCScene that contains the HomeLayer as the only child
+ (CCScene *) scene;

//create Login callback delegate to pass in to loginlayer on init 
- (AmigoCallbackDelegate *) createLoginCallbackDelegate;
-(void)navigateNotification:(NSNotification *)notification;
//called when user logs in
- (void) loggedInCallback;

- (void) showLoginScreen;
- (void) showPetScreen;
- (void) showFoodScreen;

- (void)saveState;
- (void)restoreState;

@end
