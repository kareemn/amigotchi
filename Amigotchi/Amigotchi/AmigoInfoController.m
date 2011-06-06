//
//  AmigoInfoController.m
//  Amigotchi
//
//  Created by Kareem Nassar on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoInfoController.h"
#import "AppDelegate.h"

@implementation AmigoInfoController

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
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (toggleCheckins != nil) {
        toggleCheckins.on = delegate.api.facebookCheckinEnabled;
    }
    
    if (logoutButton != nil) {
        UIImage *logoutImage = [UIImage imageNamed:@"LogoutNormal.png"];
        [logoutButton setImage:logoutImage forState:UIControlStateNormal];
        [logoutImage release];
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

- (IBAction) facebookCheckinToggled:(id)sender{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.api.facebookCheckinEnabled = toggleCheckins.on;
}


- (IBAction) logoutPressed:(id)sender{
    NSLog(@"logging out");
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:AMIGONAVNOTIFICATION object:@"loggingout"]];
    
}

@end
