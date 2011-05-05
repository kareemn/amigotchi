//
//  CFTetrisAppDelegate.h
//  CFTetris
//
//  Created by Kareem Nassar on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TetrisEngine.h"
#import "UglyTetrisViewController.h"
#import "MemoryHound.h"

@interface CFTetrisAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    int fromInactive;
    BOOL running;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UglyTetrisViewController *uglyViewController;
@property (nonatomic, retain) TetrisEngine *engine;

- (void) saveState;
- (void) restoreState;

@end
