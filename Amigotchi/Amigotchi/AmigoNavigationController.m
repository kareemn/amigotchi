//
//  AmigoNavigationController.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoNavigationController.h"
#import "AmigoConfig.h"
#import "AmigoTableViewController.h"
#import "MapViewController.h"

@implementation AmigoNavigationController

- (id) initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    [self.navigationBar setTintColor:[UIColor purpleColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateNotification:) name:AMIGONAVCONTROLLER object:nil];
    
    return self;
}

-(void)navigateNotification:(NSNotification *)notification{
    
    // NSLog([[notification userInfo] description]);
    //NSLog([[notification object] description]);
    //NSLog(@"inputFromView:: received %@.\n", [notification object]);
    
    NSString *theobj = [notification object];
    
    if([theobj isEqualToString:@"checkin"])
    {
        NSLog(@"app del got stuff");
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGOAPINOTIFICATION object:@"updateNearbyPlaces"]];
        [self pushViewController: [[[AmigoTableViewController alloc] init ] autorelease] animated:YES];
        
    }
    
    else if ( [theobj isEqualToString:@"map"] ){
        NSLog(@"app del got stuff");
        [self pushViewController:[[MapViewController
                                   alloc]init] animated:YES];
    }
    
}

@end
