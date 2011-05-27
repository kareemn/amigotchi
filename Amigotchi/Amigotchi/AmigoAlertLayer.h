//
//  AmigoAlertLayer.h
//  Amigotchi
//
//  Created by Elliott Kipper on 5/26/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AmigoAlertView.h"

@interface AmigoAlertLayer : CCLayer {
    
}
@property (nonatomic, retain) AmigoAlertView * myView;

-(void)displayAlertWithString:(NSString*)stringLabel andPicture:(NSString*)picturePath;
@end
