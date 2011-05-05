//
//  MemoryHound.m
//  UglyCFTetris
//
//  Created by John Bellardo on 4/13/11.
//  Copyright 2011 California State Polytechnic University, San Luis Obispo. All rights reserved.
//

#import "MemoryHound.h"

static MemoryHound *hound = nil;

@implementation MemoryHound
@synthesize window = _window;

+ (void) startHound
{
    hound = [[MemoryHound alloc] init];
}

- (id) init
{
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(didRotate:)
         name:UIDeviceOrientationDidChangeNotification object:nil];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];     
    }
    return self;
}

- (void) didRotate:(NSNotification *)notification
{
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        if (self == [UIApplication sharedApplication].delegate)
            return;
        
        self.window = [UIApplication sharedApplication].keyWindow;
        UIViewController *ctl = self.window.rootViewController;
        self.window.rootViewController = nil;
        
        id oldDel = [UIApplication sharedApplication].delegate;
        [UIApplication sharedApplication].delegate = self;
        [oldDel release];
        
        // This is an UGLY HACK.
        // NEVER DO THIS IN YOUR CODE.  EVER.  PERIOD!!!!!!!!!!!
        for (int cnt = [ctl retainCount] - 1; cnt > 0; cnt--)
            [ctl release];
    }
}

- (void) dealloc
{
    [_window release];
    [super dealloc];
}

@end
