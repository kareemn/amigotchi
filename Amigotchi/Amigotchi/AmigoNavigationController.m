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
#import "AmigoInfoController.h"

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
        NSLog(@"AmigoNavigationController got a notification.\n");
        AmigoTableViewController *tableController = [[AmigoTableViewController alloc] init ];
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGOAPINOTIFICATION object:@"updateNearbyPlaces"]];
        
        [self pushViewController: tableController animated:YES];
        [tableController release];
    }
    
    else if ( [theobj isEqualToString:@"map"] ){
        NSLog(@"app del got stuff");
        MapViewController *mapController = [[MapViewController alloc]init];
        [self pushViewController:mapController animated:YES];
        [mapController release];
    }
    
    else if ( [theobj isEqualToString:@"info"] ){
        NSLog(@"app del got stuff");
        AmigoInfoController *infoController = [[AmigoInfoController alloc]init];
        [self pushViewController:infoController animated:YES];
        [infoController release];
    }
    
    else if( [theobj isEqualToString:@"showHowTo"] )
    {
        HowToViewController * hvc = [[HowToViewController alloc] init];
        [self pushViewController:hvc animated:YES];
        [hvc release];
    }
    
}

@end
