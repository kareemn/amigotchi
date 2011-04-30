//
//  AmigoConfig.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SKY_LAYER 1
#define GROUND_LAYER 3
#define PET_LAYER 5
#define LOGIN_LAYER 6
#define HUD_LAYER 9

#define MENU_HEIGHT 50

#define MAX_HUNGER 20
#define MAX_BATHROOM 40
#define MAX_HAPPINESS 20

#define BUTTON_FEED 1
#define BUTTON_CHECKIN 2
#define BUTTON_MAP 3

//facebook app id
static NSString* kAppId = @"196872950351792";

//notifications event types
static NSString* PETVIEWCHANGE = @"petView";
static NSString* LOGINVIEWCHANGE = @"loginView";