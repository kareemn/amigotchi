//
//  CFTetrisAppDelegate.m
//  CFTetris
//
//  Created by Kareem Nassar on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CFTetrisAppDelegate.h"

@implementation CFTetrisAppDelegate


@synthesize window=_window;
@synthesize uglyViewController = uglyViewController_;
@synthesize engine = engine_;
@synthesize tabBarController=_tabBarController;


- (void) saveState {
    NSDictionary *state = [self.engine currentState];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:state forKey:@"gameState"];
    [defaults synchronize];
}

- (void) restoreState{
    NSLog(@"restoring state");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *state = [defaults valueForKey:@"gameState"];
    
    //NSLog(@"state is %@", [state description]);
    
    if(state == nil){
        NSLog(@"state is nil");
        return;
    }
    
    self.engine =  [[TetrisEngine alloc] initWithState:state];
    
    
    [[self.tabBarController.viewControllers objectAtIndex:0] setEngine:self.engine];
    [[self.tabBarController.viewControllers objectAtIndex:1] setEngine:self.engine];
    
    NSLog(@"AppDelegate restoreState: %@", self.engine);
    
    NSLog(@"done in restore state");
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    NSLog(@"didFinishLaunchingWithOptions");
    [MemoryHound startHound];
    // Override point for customization after application launch.
    [self restoreState];
    
    if(self.engine == nil){
        NSLog(@"engine is still nil after restoreState");
        self.engine = [[TetrisEngine alloc] initWithHeight:10];
        [[self.tabBarController.viewControllers objectAtIndex:0] setEngine:self.engine];
        [[self.tabBarController.viewControllers objectAtIndex:1] setEngine:self.engine];
    }
    
    
    if( self.engine == nil ){
        NSLog(@"engine is nil");
    }
    
    
    /*
     self.window.rootViewController = self.uglyViewController;
    [self.window makeKeyAndVisible];
    return YES;
    */
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    fromInactive = [self.engine timeStep];
    self.engine->shouldBeRunning = [self.engine isRunning];
    [self.engine stop];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    NSLog(@"applicationDidEnterBackground");
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    fromInactive = NO;
    self.engine->shouldBeRunning = NO;
    
    running = [self.engine isRunning];
    [self.engine stop];
    
    
    [self saveState];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"applicationWillEnterForeground");
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
    [self restoreState];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    (self.engine)->antigravity = [defaults boolForKey:@"antigravity"];
    
    NSLog(@"AppDelegate willEnterFore: %@", self.engine);
    
    if ((self.engine)->antigravity) {
        NSLog(@"antigravity is on");
    }
    else{
        NSLog(@"antigravity is off");
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    if (fromInactive) {
        self.engine.timeStep = fromInactive;
        
        
        if (self.engine->shouldBeRunning) {
            [self.engine start];
        }
        else {
            [self.engine stop];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    self.engine->shouldBeRunning = [self.engine isRunning];
    NSLog(@"applicationWillTerminate");
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    fromInactive = NO;
    [self.engine stop];
    [self saveState];
}

- (void)dealloc
{
    [engine_ release];
    [uglyViewController_ release];
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
