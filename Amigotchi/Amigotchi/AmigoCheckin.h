//
//  AmigoCheckin.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKMapView.h>

@interface AmigoCheckin : NSObject<MKAnnotation> {
}

@property (nonatomic, retain) NSNumber *place_id;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lon;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;

@end
