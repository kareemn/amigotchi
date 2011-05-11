//
//  AmigoMapAnnotation.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKMapView.h>


@interface AmigoMapAnnotation : NSObject<MKAnnotation> {

}
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;


@end
