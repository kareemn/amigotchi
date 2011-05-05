//
//  FirstViewController.m
//  CFTetris
//
//  Created by Kareem Nassar on 5/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController

@synthesize engine = engine_;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTetrisView];
}


- (void) setupTetrisView {
    if( tetrisView != nil){
        tetrisView.width = self.engine.width;
        tetrisView.height = self.engine.height;
        
        tetrisView.callback = @selector(panTetris:amount:);
        tetrisView.tapcallback = @selector(tapTetris:);
        tetrisView.twotouchtapcallback = @selector(twoTouchTapTetris:);
        tetrisView.target = self;
        
        [tetrisView refreshGrid];
        [tetrisView setNeedsDisplay];
        
        return;
    }
    
    
    tetrisView = [[TetrisView alloc] 
                  initWithFrame: self.view.bounds andHeight:self.engine.height andWidth:self.engine.width];
}

- (void) tapTetris: (TetrisView*) theView{
    if ([self.engine isRunning]) {
        [self.engine rotateCW];
    }
    else {
        [self.engine start];
    }
}



- (void) twoTouchTapTetris: (TetrisView *)theView{
    if ([self.engine isRunning]) {
        [self.engine stop];
    }
    else {
        [self.engine start];
    }
}


- (void) panTetris: (TetrisView*) theView amount: (TetrisPanData*)data{
    NSLog(@"panning tetris");
    
    CGPoint delta = data.distance;
    xsofar += delta.x;
    ysofar += delta.y;
    
    if (xsofar > cellwidth) {
        [self.engine slideRight];
        xsofar = 0;
    }
    else if ( xsofar < -1 * cellwidth ){
        [self.engine slideLeft];
        xsofar = 0;
    }
    
    if (ysofar > cellheight) {
        [self.engine pieceDown];
        ysofar = 0;
    }
    else if ( ysofar < -1 * cellheight ){
        [self.engine pieceUp];
        ysofar = 0;
    }
    

    /*
    else {
        for (int i = 0; i < -x; i++) {
            [self.engine slideLeft];
        }
    }
    */
}

- (id) init{
    self = [super init];
    if(self != nil){
        self->xsofar = 0;
        self->ysofar = 0;
    }
    
    return self;
}
- (void)setEngine:(TetrisEngine *)eng{
    
    [self loadView];
    engine_ = eng;
    
    [self.engine addObserver:self forKeyPath:@"score" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:nil];
    [self.engine addObserver:self forKeyPath:@"timeStep" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:nil];
    [self.engine addObserver:self forKeyPath:@"gridVersion" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:nil];
    
    self->cellheight =  self.view.frame.size.height/self.engine.height;
    self->cellwidth  = self.view.frame.size.width/self.engine.width;
    [self setupTetrisView];
    
    [self refreshView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void) refreshView{
    
    
    
    for (int row = 0; row < self.engine.height; row++) {
        for (int col = 0; col < self.engine.width; col++) {
            
            int num = [self.engine pieceAtRow:row column:col ];
            /*
            if( num == 0 ){
                [tetrisView setColor:[UIColor whiteColor] forRow:row column:col];
            }
            else {
                
                [tetrisView setColor:[self.engine getCurrPieceColor] forRow:row column:col];
            }
             */
            
            switch (num) {
                case ITetromino:
                    [tetrisView setColor: [UIColor cyanColor] forRow:row column:col];
                    break;
                case JTetromino:
                    [tetrisView setColor: [UIColor blueColor] forRow:row column:col];                    break;
                case LTetromino:
                    [tetrisView setColor: [UIColor orangeColor] forRow:row column:col];
                    break;
                case OTetromino:
                    [tetrisView setColor: [UIColor yellowColor] forRow:row column:col];
                    break;
                case STetromino:
                    [tetrisView setColor: [UIColor greenColor] forRow:row column:col];
                    break;
                case TTetromino:
                    [tetrisView setColor: [UIColor purpleColor] forRow:row column:col];
                    break;
                case ZTetromino:
                    [tetrisView setColor:  [UIColor redColor] forRow:row column:col];
                    break;
                default:
                    [tetrisView setColor:  [UIColor whiteColor] forRow:row column:col];
                    break;
            }

        }
    }
    [tetrisView setNeedsDisplay];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context
{
    
    if ([keyPath isEqualToString:@"score"]) {
        //NSLog(@"FirstViewController::score changed");
        scoreLabel.text = [NSString stringWithFormat:@"%d", [self.engine score] ];
    }
    else if( [keyPath isEqualToString:@"timeStep"] ){
        //NSLog(@"FirstViewController::timestep changed");
        timeLabel.text = [NSString stringWithFormat:@"%d", [self.engine timeStep] ];
    }
    else if( [keyPath isEqualToString:@"gridVersion"] ){
        //NSLog(@"FirstViewController::gridversion changed");
        [self refreshView];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self.engine reset];
}


- (void)dealloc
{
    [self.engine stop];
    [self.engine removeObserver:self forKeyPath:@"score"];
    [self.engine removeObserver:self forKeyPath:@"timeStep"];
    [self.engine removeObserver:self forKeyPath:@"gridVersion"];
    [engine_ release];
    
    engine_ = nil;
    
    [scoreLabel release];
    [timeLabel release];
    [tetrisView release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    [timeLabel release];
    [scoreLabel release];
    
    
    
}

@end
