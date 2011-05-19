//
//  AmigoTableViewController.h
//  Amigotchi
//
//  Created by Kareem Nassar on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AmigoTableViewController : UITableViewController {
    UIActivityIndicatorView *spinner;
}

@property (nonatomic, retain) NSArray *placesArray;

@end
