//
//  UglyTetrisViewController.h
//  UglyTetris
//
//  Created by Kareem Nassar on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TetrisEngine.h"

@interface UglyTetrisViewController : UIViewController {
    @private
    IBOutlet UILabel    *timeLabel;
    IBOutlet UILabel    *scoreLabel;
    NSMutableArray *gridLabels;
}

@property(nonatomic, retain, readwrite) TetrisEngine *engine;

- (IBAction) buttonPressed:(UIButton*)sender;
- (void) startButtonPressed;
- (void) stopButtonPressed;
- (void) resetButtonPressed;

- (void) setEngine:(TetrisEngine*)eng;
- (void) refreshView;


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context;

@end
