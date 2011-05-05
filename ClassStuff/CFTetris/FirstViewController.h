//
//  FirstViewController.h
//  CFTetris
//
//  Created by Kareem Nassar on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TetrisView.h"
#import "TetrisEngine.h"

@interface FirstViewController : UIViewController {
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet TetrisView *tetrisView;
    
    int cellheight;
    int cellwidth;
    
    int xsofar;
    int ysofar;
    
}
- (void) panTetris: (TetrisView*) theView amount: (TetrisPanData*)data;
- (void) tapTetris: (TetrisView*) theView;
- (void) twoTouchTapTetris: (TetrisView *)theView;

- (void) setupTetrisView;
- (void) refreshView;
@property (nonatomic, retain) TetrisEngine *engine;

@end
