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
#import "AmigoPet.h"
#import "AmigoConfig.h"


#define MENU_HEIGHT 50

// HomeLayer
@interface HomeLayer : CCLayer
{    

}

// returns a CCScene that contains the HomeLayer as the only child
+(CCScene *) scene;


@end
