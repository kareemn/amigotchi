//
//  AmigoInfoController.h
//  Amigotchi
//
//  Created by Kareem Nassar on 6/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AmigoInfoController : UIViewController {
    IBOutlet UISwitch *toggleCheckins;
    IBOutlet UIButton *logoutButton;
}

- (IBAction) facebookCheckinToggled:(id)sender;
- (IBAction) logoutPressed:(id)sender;

@end
