//
//  AmigoCheckinViewController.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoCheckinViewController.h"
#import "AppDelegate.h"

@implementation AmigoCheckinViewController

@synthesize checkin = checkin_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [checkin_ release];
    [checkinTitle release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    if (self.checkin != nil) {
        self.title = self.checkin.title;
        NSLog(@"place id is %@", self.checkin.place_id);
        NSLog(@"lon is %@", self.checkin.lon);
        NSLog(@"lat is %@", self.checkin.lat);
        
        checkinTitle.text = [NSString stringWithFormat:@"Checking in helps your dragon grow! Are you sure you would like to check in to %@?", self.checkin.title];
        button.target = self;
        button.action = @selector(backHome);
    }
     
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)backHome
{
    /*
    if([self.checkin.title isEqualToString:@"California Polytechnic State University San Luis Obispo Campus"])
    {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:PETVIEWCHANGE object:@"acc:cowboy hat"]];   
    }
    else if([self.checkin.title isEqualToString:@"Sierra Vista Regional Medical Center"] ||
            [self.checkin.title isEqualToString:@"Robert E. Kennedy library"])
    {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:PETVIEWCHANGE object:@"acc:glasses"]];   
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:PETVIEWCHANGE object:@"acc:none"]];
    }
     */
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    [delegate.api checkin:self.checkin];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end