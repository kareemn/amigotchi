//
//  AmigoAPI.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

#import "AmigoUser.h"
#import "cocos2d.h"

@interface AmigoAPI : NSObject {
    ASINetworkQueue         *queue;
    AmigoUser               *user;
    
    /*layer to notify whenever user change occurs */
    CCLayer                 *userLayer;
    
    
}

@property (nonatomic, readwrite, retain) ASINetworkQueue      *queue;
@property (nonatomic, readwrite, retain) AmigoUser            *user;
//@property (nonatomic, readwrite, retain) AmigoPet             *pet;


@property (nonatomic, readwrite, retain) CCLayer              *userLayer;

-(void)login:(NSString*)access_token;


//helpers
- (id)parseJsonResponse:(NSString *)responseString;

@end
