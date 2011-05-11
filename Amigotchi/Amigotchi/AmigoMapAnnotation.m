//
//  AmigoMapAnnotation.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoMapAnnotation.h"


@implementation AmigoMapAnnotation
@synthesize title = title_;
@synthesize subtitle = subtitle_;
@synthesize coordinate = coordinate_;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    self = [super init];
    
    if(self != nil){
       self.coordinate = c;
       NSLog(@"%f,%f",c.latitude,c.longitude);
    }
    
    return self;
}

- (void)dealloc {
    [title_ release];
    [subtitle_ release];
    
    [super dealloc];
}
@end
