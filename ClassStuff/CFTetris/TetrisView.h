//
//  PrettyView.h
//  CFTetris
//
//  Created by Kareem Nassar on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TetrisPanData : NSObject {
}
@property (nonatomic) CGPoint distance;
@property (nonatomic) UIGestureRecognizerState state;
@end


@interface TetrisView : UIView {
    
}

- (id) initWithFrame:(CGRect)frame andHeight:(int)height andWidth:(int)width;
- (void) setColor: (UIColor*)color forRow: (int) row column:(int) col;
- (void) refreshGrid;
- (void) setupGestures;
- (void) handlePanGesture: (UIPanGestureRecognizer*)sender;
- (void) handleTapGesture: (UIPanGestureRecognizer*)sender;

@property ( nonatomic) int height;
@property ( nonatomic) int width;
@property ( nonatomic, retain) id target;
@property (nonatomic) SEL callback;
@property (nonatomic) SEL tapcallback;
@property (nonatomic) SEL twotouchtapcallback;
@property ( nonatomic, readwrite, retain ) NSMutableArray *array;



@end
