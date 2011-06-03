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
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.api.mapViewController = self;
        
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


- (void) drawCheckins:(NSArray *)checkins{
    NSLog(@"drawing checkins");
    for(id c in checkins){
        
        if (! [c isKindOfClass:[NSDictionary class]] ) {
            continue;
        }
        
        NSLog(@"drawing checkin: %@\n", [c description]);
        NSString *latstring = [c objectForKey:@"lat"];
        NSString *lonstring = [c objectForKey:@"lon"];
        
        float lat = [latstring floatValue];
        float lon = [lonstring floatValue];
        
        CLLocationCoordinate2D thisloc;
        thisloc.latitude = lat;
        thisloc.longitude = lon;
        AmigoCheckin *thisMark = [[AmigoCheckin alloc] initWithCoordinate:thisloc];
        
        thisMark.title = [c objectForKey:@"title"];
        thisMark.subtitle = [c objectForKey:@"owner"];
        
        [mView addAnnotation:thisMark];
        
        [thisMark release];
    }

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

- (void) centerOnUserLocation{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta=0.6;
    span.longitudeDelta=0.6;
    
    region.span=span;
    region.center= mView.userLocation.location.coordinate;
    if (mView.userLocation.location.verticalAccuracy) {
        
    }
    [mView setRegion:region animated:TRUE];
    [mView regionThatFits:region];
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
        [self centerOnUserLocation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
