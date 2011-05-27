//
//  MapViewController.h
//  Amigotchi
//
//  Created by Elliott Kipper on 5/16/11.
//  Copyright 2011 kipgfx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>
#import <MapKit/MKUserLocation.h>

@interface MapViewController : UIViewController {
    IBOutlet MKMapView * mView;
}

@property (nonatomic, retain) NSArray *checkins;

- (void) centerOnUserLocation;
- (void) drawCheckins;

@end
