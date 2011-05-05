//
//  MemoryHound.h
//  UglyCFTetris
//
//  Created by John Bellardo on 4/13/11.
//  Copyright 2011 California State Polytechnic University, San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MemoryHound : NSObject <UIApplicationDelegate> {
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

// Call startHound once in your App Delegate's application:didFinishLaunchingwithOptions: method.
+ (void) startHound;

- (void) didRotate:(NSNotification *)notification;

@end