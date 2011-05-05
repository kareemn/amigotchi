//
//  UglyTetrisViewController.m
//  UglyTetris
//
//  Created by Kareem Nassar on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UglyTetrisViewController.h"

@interface UglyTetrisViewController()

-(void)setupLabels;

@end


@implementation UglyTetrisViewController

@synthesize engine=_engine;

- (void)dealloc
{
    [self.engine stop];
    [self.engine removeObserver:self forKeyPath:@"score"];
    [self.engine removeObserver:self forKeyPath:@"timeStep"];
    [self.engine removeObserver:self forKeyPath:@"gridVersion"];
    [gridLabels release];
    [timeLabel release];
    [scoreLabel release];

    [self.engine release];
    
    
    
    [super dealloc];
}

- (void)setEngine:(TetrisEngine *)eng{
    
    NSLog(@"in user defined setEngine");
    
    [self loadView];
    _engine = eng;
    
    NSLog(@"ViewController setEngine: %@", _engine);
    
    NSLog(@"retain count is now %@ , %@", [NSNumber numberWithInt:[eng retainCount]], [NSNumber numberWithInt:[_engine retainCount]]);
    
    [self.engine addObserver:self forKeyPath:@"score" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:nil];
    [self.engine addObserver:self forKeyPath:@"timeStep" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:nil];
    [self.engine addObserver:self forKeyPath:@"gridVersion" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:nil];
    
    [self setupLabels];
    [self refreshView];
}

-(void)setupLabels {
    NSLog(@"setupLabels");
    if(  self.engine == nil || ![self isViewLoaded]){
        NSLog(@"gridLabels already set up!");
        return;
    }
    
    [gridLabels release];
    gridLabels = [[NSMutableArray alloc] initWithCapacity:TetrisArrSize([self.engine height])];
    for (int row = 0; row < [self.engine height]; row++) {
        for(int column = 0; column < [self.engine width]; column++){
            CGRect frame;
            frame.size.width = 16; 
            frame.size.height = 26; 
            frame.origin.x = 130 + frame.size.width * column; 
            frame.origin.y = 300 - frame.size.height * row;
            
            //gridLabels[TetrisArrIdx(row, column)] = [ [UILabel alloc] initWithFrame:frame];
            
            UILabel *newLabel = [[UILabel alloc] initWithFrame:frame];
            [gridLabels addObject:newLabel];
            
            [self.view addSubview:newLabel];
            [newLabel release];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLabels];
}

- (void) refreshView{
    
    if (!self.engine || !gridLabels) {
        return;
    }
    
    for (int column = 0; column < [self.engine width]; column++) {
        for(int row = 0; row < [self.engine height]; row++){
            int piece = [self.engine pieceAtRow:row column:column];
            UILabel *theLabel = [gridLabels objectAtIndex:TetrisArrIdx(row, column)];
            
            if(piece == 0){
                theLabel.text = @".";
                //gridLabels[TetrisArrIdx(row, column)].text = @".";
            }
            else {
                theLabel.text = @"X";
                //gridLabels[TetrisArrIdx(row, column)].text = @"X";
            }
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [gridLabels release];
    gridLabels = nil;
    
    [timeLabel release];
    [scoreLabel release];
    
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSLog(@"Button pressed with tag: %d", sender.tag);
    
    switch (sender.tag) {
        case 1:
            NSLog(@"start button");
            [self startButtonPressed];
            break;
        case 2:
            NSLog(@"left button");
            [self.engine slideLeft];
            break;
        case 3:
            NSLog(@"right button");
            [self.engine slideRight];
            break;
        case 4:
            NSLog(@"cw button");
            [self.engine rotateCW];
            break;
        case 5:
            NSLog(@"ccw button");
            [self.engine rotateCCW];
            break;
        case 6:
            NSLog(@"stop button");
            [self stopButtonPressed];
            break;
        case 7:
            NSLog(@"reset button");
            [self resetButtonPressed];
            break;
        case 8:
            NSLog(@"down button");
            [self.engine pieceDown];
            break;
        case 9:
            NSLog(@"up button");
            [self.engine pieceUp];
            break;
        default:
            break;
    }
}

-(void) startButtonPressed {
    [self.engine start];
}

-(void) stopButtonPressed {
    [self.engine stop];
}

- (void) resetButtonPressed {
    [self.engine reset];
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context
{
    
    if ([keyPath isEqualToString:@"score"]) {
        NSLog(@"UglyTetris::score changed");
        scoreLabel.text = [NSString stringWithFormat:@"%d", [self.engine score] ];
    }
    else if( [keyPath isEqualToString:@"timeStep"] ){
        NSLog(@"UglyTetris::timestep changed");
        timeLabel.text = [NSString stringWithFormat:@"%d", [self.engine timeStep] ];
    }
    else if( [keyPath isEqualToString:@"gridVersion"] ){
        NSLog(@"UglyTetris::gridversion changed");
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


@end
