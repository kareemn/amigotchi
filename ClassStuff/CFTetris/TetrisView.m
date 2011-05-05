//
//  PrettyView.m
//  CFTetris
//
//  Created by Kareem Nassar on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TetrisView.h"
#import "TetrisEngine.h"



@implementation TetrisPanData
@synthesize distance = distance_;
@synthesize state = state_;
@end


//private methods
@interface TetrisView ()
@property (nonatomic) CGPoint lastPan;

@end


@implementation TetrisView

@synthesize width = width_;
@synthesize height = height_;
@synthesize array = array_;
@synthesize callback = callback_;
@synthesize tapcallback = tapcallback_;
@synthesize target = target_;
@synthesize lastPan = lastPan_;
@synthesize twotouchtapcallback = twotouchtapcallback_;

// Method to configure all gesture recognizers for a MovableShape
- (void) setupGestures {
    UIPanGestureRecognizer * pgn =
    [[UIPanGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(handlePanGesture:)];
    
    [self addGestureRecognizer:pgn];
    [pgn release];
    
    UITapGestureRecognizer *tgn = 
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    tgn.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tgn];
    [tgn release];
    
    
    
    UITapGestureRecognizer *tgn2 = 
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    tgn2.numberOfTouchesRequired = 2;
    
    [self addGestureRecognizer:tgn2];
    [tgn2 release];
    
}

// Method to receive gesture events.  Translates from absolute
//  coordinates into delta values.
- (void) handleTapGesture: (UITapGestureRecognizer*)sender
{
    if (!self.array)
        return;
    
    if (sender.state != UIGestureRecognizerStateBegan &&
        sender.state != UIGestureRecognizerStateChanged &&
        sender.state != UIGestureRecognizerStateEnded)
        return;
    
    if (sender.numberOfTouchesRequired == 1) {
        
        [self.target performSelector:self.tapcallback 
                          withObject:self];
    }
    else if( sender.numberOfTouchesRequired == 2){
        [self.target performSelector:self.twotouchtapcallback withObject:self];
    }

}


// Method to receive gesture events.  Translates from absolute
//  coordinates into delta values.
- (void) handlePanGesture: (UIPanGestureRecognizer*)sender
{
    if (!self.array)
        return;
    
    CGPoint translate = [sender translationInView:self];    
    if (sender.state == UIGestureRecognizerStateBegan)
        self.lastPan = translate;
    
    if (sender.state != UIGestureRecognizerStateBegan &&
        sender.state != UIGestureRecognizerStateChanged &&
        sender.state != UIGestureRecognizerStateEnded)
        return;
    
    // Do the conversion into an <x,y> delta
    CGPoint delta = translate;
    delta.x -= self.lastPan.x;
    delta.y -= self.lastPan.y;
    
    // Populate an object to pass all the data into our target-action

    
    TetrisPanData * data = [[TetrisPanData alloc] init];
    data.distance = delta;
    
    NSLog(@"distance %f %f" ,delta.x, delta.y);
    data.state = sender.state;
    
    // Call the target-action
    [self.target performSelector:self.callback
                      withObject:self
                      withObject:data];
    
    [data release];
    self.lastPan = translate;
}

- (id)initWithFrame:(CGRect)frame
{
    
    NSLog(@"TetrisView::initWithFrame");

    self = [super initWithFrame:frame];
    if (self) {
        self.array = [NSMutableArray arrayWithCapacity:100];
        [self setupGestures];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self){
        [self setupGestures];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame andHeight:(int)height andWidth:(int)width{
    
    NSLog(@"TetrisView::initWithFrameandHeight");
    
    self = [self initWithFrame:frame];
    
    if(self){
        
        self.height = height;
        self.width = width;
        [self refreshGrid];
        
    }
    
    NSLog(@"%@", self);
    
    return self;
}

- (void) refreshGrid{
    
    if(self.array == nil){
        self.array = [NSMutableArray arrayWithCapacity:self.height * self.width];
    }
    
    //NSLog(@"refreshGrid array count is %d", [self.array count]);
    
    for (int row = 0; row < self.width; row++) {
        for (int col = 0; col < self.height; col++) {
            [self.array insertObject:[UIColor whiteColor] atIndex:TetrisArrIdx(row, col)];
            
            UIColor *color = [self.array objectAtIndex:TetrisArrIdx(row, col)];
            NSLog(@"index is %d", TetrisArrIdx(row, col));
            NSLog(@"color: %@", color);
        }
    }
}

- (void) setColor: (UIColor*)color forRow: (int) row column:(int) col {
    //NSLog(@"TetrisView::setColor");
    
    //MAY NEED TO CHANGE THIS FOR PERFORMANCE
    
    //BOOL needsChange = [color isEqual:[self.array objectAtIndex:TetrisArrIdx(row, col)]];
    
    //if (needsChange) {
    UIColor *currcolor = [self.array objectAtIndex:TetrisArrIdx(row, col)];
    if (currcolor == nil) {
        [self.array insertObject:color atIndex:TetrisArrIdx(row, col)];
        
        [self setNeedsDisplay];
    }
    else {
        //BOOL needsChange = [color isEqual:currcolor];
        //if (needsChange) {
            [self.array replaceObjectAtIndex:TetrisArrIdx(row, col) withObject:color];
            [self setNeedsDisplay];
        //}
        
    }
    //}
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    NSLog(@"TetrisView::drawRect");
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect box = self.bounds;
    
    float dw = self.bounds.size.width / ((float)self.width);
    float dh = self.bounds.size.height / ((float)self.height);
    
    
    
    NSLog(@"%@", self);
    NSLog(@"array size is %d", [self.array count]);
    
    NSLog(@"height is %d", self.height);
    NSLog(@"width is %d" , self.width);
    
    for( int row = 0; row < self.height; row++){
        for ( int col = 0; col < self.width; col++){
            
            
            box = CGRectMake(col * dw, (self.height - row - 1) * dh, dw, dh);
            
            CGContextBeginPath(context);
            CGContextAddRect(context, box);
            CGContextClosePath(context);
            
            [[UIColor blackColor] setStroke];
            
            UIColor *cellcolor = [self.array objectAtIndex:TetrisArrIdx(row, col)];
            if (cellcolor == nil) {
                [[UIColor whiteColor] setFill];
            }
            else {
                [cellcolor setFill];
            }
            
            CGContextDrawPath(context, kCGPathFillStroke);
            
        }
    }
    
    
}


- (void)dealloc
{
    
    [array_ release];
    [super dealloc];
}

@end
