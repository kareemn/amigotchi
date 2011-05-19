//
//  AmigoCheckinViewController.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmigoCheckin.h"


@interface AmigoCheckinViewController : UIViewController {
    IBOutlet UILabel *checkinTitle;
    IBOutlet UIBarButtonItem * button;
}

@property (nonatomic, retain) AmigoCheckin *checkin;

-(void)backHome;

@end
