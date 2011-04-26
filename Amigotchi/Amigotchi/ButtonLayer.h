//
//  ButtonLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface ButtonLayer : CCLayer {
    
}

@property (nonatomic, retain) CCMenuItem    *credits;

+(CCScene *) scene;
-(void)creditsButtonClicked;

@end
