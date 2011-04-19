//
//  PetLayer.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AmigoPet.h"
@interface PetLayer : CCLayer {
    
}

// returns a CCScene that contains the HomeLayer as the only child
+(CCScene *) scene;

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
@end
