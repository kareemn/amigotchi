//
//  AmigoDelegate.h
//  Amigotchi
//
//  Created by Kareem Nassar on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*interface for storing a bunch of NSString selectorNames and an object to perform it on.
 checks to make sure selectors belong to the delegate*/

@interface AmigoCallbackDelegate : NSObject {
    
}
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSSet *selectorNames;

- (id) initWithDelegate: (id)del andSelectorNameArray: (NSArray *)array;
- (BOOL) performCallback: (NSString *)selectorName; 

@end
