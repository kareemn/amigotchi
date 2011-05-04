//
//  MapView.m
//  Amigotchi
//
//  Created by Kareem Nassar on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"


@implementation MapView


- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil){
        UIToolbar *toolbar = [UIToolbar new];
        toolbar.frame = frame;
        
        [self addSubview:toolbar];
    }
    
    return self;
}

@end
