//
//  MapViewController.m
//  Amigotchi
//
//  Created by Elliott Kipper on 5/16/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"

@implementation MapViewController

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
    self.title = @"Map";
    
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    CLLocation *location = delegate.api.locdelegate.currLoc;
    NSString *lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    [delegate.api getNearbyCheckinsForLat:lat andLon:lon];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /*CLLocationCoordinate2D coord = {latitude: 37.423617, longitude: -122.220154};
    MKCoordinateSpan span = {latitudeDelta: 1, longitudeDelta: 1};
    MKCoordinateRegion region = {coord, span};
    [mView setRegion:region];*/
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
