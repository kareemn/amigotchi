//
//  User.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AmigoUser : NSObject {
    NSString        *name;
}

@property (nonatomic, readwrite, retain) NSString        *name;

@end
