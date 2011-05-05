//
//  TetrisEngine.m
//  R1
//
//  Created by John Bellardo on 3/8/11.
//  Copyright 2011 California State Polytechnic University, San Luis Obispo. All rights reserved.
//

#import "TetrisEngine.h"

#define TetrisPieceBlocks 4
#define TetrisPieceRotations 4
struct TetrisPiece {
	int name;
	struct {
		int colOff, rowOff;
	} offsets[TetrisPieceRotations][TetrisPieceBlocks];
};

// Static array that defines all rotations for every piece.
// Each <x,y> point is an offset from the center of the piece.
#define TetrisNumPieces 7
static struct TetrisPiece pieces[TetrisNumPieces] = {
	{ ITetromino,	{
						{ {-2, 0}, { -1, 0}, { 0, 0 }, {1, 0} },  // 0 deg.
						{ {0, 0}, { 0, 1}, { 0, 2 }, {0, 3} },  // 90 deg.
						{ {-2, 0}, { -1, 0}, { 0, 0 }, {1, 0} },  // 180 deg.
						{ {0, 0}, { 0, 1}, { 0, 2 }, {0, 3} },  // 270 deg.
					} },
	{ JTetromino,	{
						{ {-1, 0}, { 0, 0}, { 1, 0 }, {-1, 1} }, // 0 deg.
						{ {0, 0}, { 0, 1}, { 0, 2 }, {1, 2} }, // 90 deg.
						{ {-1, 1}, { 0, 1}, { 1, 1 }, {1, 0} }, // 180 deg.
						{ {-1, 0}, { 0, 0}, { 0, 1 }, {0, 2} }, // 270 deg.
					} },
	{ LTetromino,	{
						{ {-1, 0}, { 0, 0}, { 1, 0 }, {1, 1} }, // 0 deg.
						{ {0, 0}, { 1, 0}, { 0, 1 }, {0, 2} }, // 90 deg.
						{ {-1, 1}, { 0, 1}, { 1, 1 }, {-1, 0} }, // 180 deg.
						{ {-1, 2}, { 0, 2}, { 0, 1 }, {0, 0} }, // 270 deg.
					} },
	{ OTetromino,	{
						{ {-1, 0}, { 0, 0}, { -1, 1 }, {0, 1} }, // 0 deg.
						{ {-1, 0}, { 0, 0}, { -1, 1 }, {0, 1} }, // 90 deg.
						{ {-1, 0}, { 0, 0}, { -1, 1 }, {0, 1} }, // 180 deg.
						{ {-1, 0}, { 0, 0}, { -1, 1 }, {0, 1} }, // 270 deg.
					} },
	{ STetromino,	{
						{ {-1, 0}, { 0, 0}, { 0, 1 }, {1, 1} }, // 0 deg.
						{ {1, 0}, { 0, 1}, { 1, 1 }, {0, 2} }, // 90 deg.
						{ {-1, 0}, { 0, 0}, { 0, 1 }, {1, 1} }, // 180 deg.
						{ {1, 0}, { 0, 1}, { 1, 1 }, {0, 2} }, // 270 deg.
					} },
	{ TTetromino,	{
						{ {-1, 0}, { 0, 0}, { 1, 0 }, {0, 1} }, // 0 deg.
						{ {0, 0}, { 0, 1}, { 1, 1 }, {0, 2} }, // 90 deg.
						{ {-1, 1}, { 0, 1}, { 1, 1 }, {0, 0} }, // 180 deg.
						{ {0, 1}, { 1, 0}, { 1, 1 }, {1, 2} }, // 270 deg.
					} },
	{ ZTetromino,	{
						{ {-1, 1}, { 0, 0}, { 1, 0 }, {0, 1} }, // 0 deg.
						{ {0, 0}, { 0, 1}, { 1, 1 }, {1, 2} }, // 90 deg.
						{ {-1, 1}, { 0, 0}, { 1, 0 }, {0, 1} }, // 180 deg.
						{ {0, 0}, { 0, 1}, { 1, 1 }, {1, 2} }, // 270 deg.
					} }
};


@interface TetrisEngine()

-(void)advance;

@end


@implementation TetrisEngine
@synthesize score = _score, timeStep = _timeStep, height = _height, gridVersion = _gridVersion, stepTimer = _stepTimer;
- (id) init
{
    self = [self initWithHeight: 20];
	return self;
}

- (void) dealloc{
    [grid release];
    [super dealloc];
}

- (id) initWithState:(NSDictionary *)state{
    NSLog(@"initWithState\n");
    
    NSNumber *nsheight = [state objectForKey:@"height"];
    int h = [nsheight intValue];
    
    
    self = [self initWithHeight: h];
    
    if(self){
        self.score = [[state objectForKey:@"score"] intValue];
        self.timeStep = [[state objectForKey:@"timeStep"] intValue];
        NSLog(@"timeStep is %d", self.timeStep);
        
        NSArray *gridCopy = [state objectForKey:@"grid"] ;
        
        for (int row = 0; row < [self height]; row++) {
            for(int col = 0; col < [self width]; col++){
                [self->grid replaceObjectAtIndex:TetrisArrIdx(row, col) withObject:[gridCopy objectAtIndex:TetrisArrIdx(row, col)]];
            }
        }
        
        
        NSLog(@"initWithState grid count %d", [grid count]);
        
        
        NSNumber *currpiecenum = [state objectForKey:@"currPiece"];
        if (currpiecenum != nil) {
            int name = [currpiecenum intValue];
            for (int i = 0; i < TetrisNumPieces; i++) {
                if( pieces[i].name == name ){
                    currPiece = &pieces[i];
                    break;
                }
            }
        }
        
        pieceRow = [[state objectForKey:@"pieceRow"] intValue];
        pieceCol = [[state objectForKey:@"pieceCol"] intValue];
        pieceRotation = [[state objectForKey:@"pieceRotation"] intValue];
        
        gameOver = [[state objectForKey:@"gameOver"] boolValue];
        running = [[state objectForKey:@"running"] boolValue];
        
        self.gridVersion = 0;
    }
    
    return self;
}

- (id) initWithHeight: (int) h
{
	self = [super init];
	if (self) {
		srandom(time(0));
		self.height = h;
		//grid = [[NSMutableArray alloc] initWithCapacity: TetrisArrSize(self.height)]; 
        self->grid = [ [NSMutableArray alloc] initWithCapacity:TetrisArrSize(self.height)];
        
        NSLog(@"grid count is %@", [grid count]);
        //malloc(sizeof(int) * TetrisArrSize(self.height));
        self.score = 0;
        self.gridVersion = 0;
	}
    
    for (int row = 0; row < [self height]; row++) {
        for(int col = 0; col < [self width]; col++){
            [self->grid addObject:[ NSNumber numberWithInt:0]];
        }
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    self->antigravity = [defaults boolForKey:@"antigravity"];
    
    [self reset];
	return self;
}

// Add the next floating piece to the game board
- (void) nextPiece
{
	currPiece = &pieces[ ((random() % (TetrisNumPieces * 113)) + 3) % TetrisNumPieces];
	pieceCol = [self width] / 2;
	pieceRow = self.height - 1;
	pieceRotation = 0;
}

// Returns YES if the current floating piece will colide with another game board object or
//  edge given a new row / column / rotation value
- (BOOL) currPieceWillCollideAtRow: (int) row col: (int) col rotation: (int) rot
{
	if (!currPiece)
		return NO;
	
	for (int blk = 0; currPiece && blk < TetrisPieceBlocks; blk++) {
		int checkRow = row + currPiece->offsets[rot][blk].rowOff;
		int checkCol = col + currPiece->offsets[rot][blk].colOff;
		
		if (checkRow < 0 || checkCol < 0 || checkCol >= [self width])
			return YES;

		// Enables the board to extend upwards past the screen.  Useful
		// when rotating pieces very early in their fall.
		if (checkRow >= self.height)
			continue;
		
        NSNumber *num = [self->grid objectAtIndex:TetrisArrIdx(checkRow, checkCol)];
		if ([num intValue] != NoTetromino)
			return YES;
	}

	return NO;
}

// Returns YES if any part of the current piece is off the grid
- (BOOL) currPieceOffGrid
{
	if (!currPiece)
		return NO;
	
	for (int blk = 0; currPiece && blk < TetrisPieceBlocks; blk++) {
		int checkRow = pieceRow + currPiece->offsets[pieceRotation][blk].rowOff;
		int checkCol = pieceCol + currPiece->offsets[pieceRotation][blk].colOff;
		
		if (checkRow < 0 || checkRow >= [self height] ||
			checkCol < 0 || checkCol >= [self width])
			return YES;
	}
	
	return NO;
}


- (int) width
{
	return TetrisNumCols;
}



- (void) slideLeft
{
	if (![self currPieceWillCollideAtRow: pieceRow col: pieceCol - 1 rotation: pieceRotation])
		pieceCol--;
    self.gridVersion++;
}

- (void) slideRight
{
	if (![self currPieceWillCollideAtRow: pieceRow col: pieceCol + 1 rotation: pieceRotation])
		pieceCol++;
    self.gridVersion++;
}

- (void) rotateCW
{
	if (![self currPieceWillCollideAtRow: pieceRow col: pieceCol
								rotation: (pieceRotation + 1) % TetrisPieceRotations])
		pieceRotation = (pieceRotation + 1) % TetrisPieceRotations;
    self.gridVersion++;
}

- (void) rotateCCW
{
	int newRot = pieceRotation - 1;
	while (newRot < 0)
		newRot += TetrisPieceRotations;
	if (![self currPieceWillCollideAtRow: pieceRow col: pieceCol
								rotation: newRot])
		pieceRotation = newRot;
    
    self.gridVersion++;
}

- (int) pieceAtRow: (int) row column: (int)col
{
	for (int blk = 0; currPiece && blk < TetrisPieceBlocks; blk++) {
		if (row == (currPiece->offsets[pieceRotation][blk].rowOff + pieceRow) &&
			col == (currPiece->offsets[pieceRotation][blk].colOff + pieceCol) )
			return currPiece->name;
	}
    
    id result = [self->grid objectAtIndex:TetrisArrIdx(row, col)];
    
    if( [result isKindOfClass:[NSNumber class]] ){
        NSNumber *num = result;
        return [num intValue];
    }
    else {
        return 0;
    }
}

- (void) commitCurrPiece
{
	// Copy current floating piece into grid state
	for (int blk = 0; currPiece && blk < TetrisPieceBlocks; blk++) {
        
        [self->grid replaceObjectAtIndex:TetrisArrIdx(currPiece->offsets[pieceRotation][blk].rowOff + pieceRow,
                                                      currPiece->offsets[pieceRotation][blk].colOff + pieceCol) withObject: [NSNumber numberWithInt:currPiece->name]];
        
		//self->grid[TetrisArrIdx(currPiece->offsets[pieceRotation][blk].rowOff + pieceRow,
		//						currPiece->offsets[pieceRotation][blk].colOff + pieceCol)] =
		//currPiece->name;
	}

	currPiece = NULL;
	
	// Check for lines that can be eliminated from grid
	int elimRowCnt = 0;
	for (int dstRow = 0; dstRow < [self height]; dstRow++) {
		int checkCol = 0;
		for (; checkCol < TetrisNumCols &&
			 [((NSNumber *)[self->grid objectAtIndex:TetrisArrIdx(dstRow, checkCol) ]) intValue] != NoTetromino; checkCol++)
			;
		if (checkCol < TetrisNumCols)
			continue;
		
		// Copy grid state into board
		elimRowCnt++;
		for (int srcRow = dstRow + 1; srcRow < [self height]; srcRow++)
			for (int srcCol = 0; srcCol < TetrisNumCols; srcCol++){
                [self->grid replaceObjectAtIndex:TetrisArrIdx(srcRow - 1, srcCol) withObject:[self->grid objectAtIndex:TetrisArrIdx(srcRow, srcCol)]];
            }

		for (int col = 0; col < TetrisNumCols; col++)
			[self->grid replaceObjectAtIndex:TetrisArrIdx([self height] - 1, col) withObject:[NSNumber numberWithInt:NoTetromino] ];
		dstRow--;
	}
    
    if (elimRowCnt == 1) {
        self.score += 100;
    }
    else if(elimRowCnt == 2 ){
        self.score += 250;
    }
    else if(elimRowCnt == 3) {
        self.score += 450;
    }
    else if(elimRowCnt == 4) {
        self.score += 700;
    }
    else if(elimRowCnt >= 5){
        self.score += 1000;
    }
    
    self.gridVersion++;
}

- (void) advance
{
	if (gameOver)
		return;
	
	self.timeStep++;
	if (!currPiece)
		[self nextPiece];
	else if (![self currPieceWillCollideAtRow: pieceRow - 1 col: pieceCol  rotation: pieceRotation])
		pieceRow--;
	else if (![self currPieceOffGrid])
		[self commitCurrPiece];
	else
		gameOver = YES;
    
    self.gridVersion++;
    
}

- (void) reset{
    
    currPiece = nil;
    for (int row = 0; row < [self height]; row++) {
        for(int col = 0; col < [self width]; col++){
            [self->grid replaceObjectAtIndex:TetrisArrIdx(row, col) withObject:[NSNumber numberWithInt:0] ];
        }
    }
	gameOver = NO;
    self.score = 0;
    self.timeStep = 0;
    self.gridVersion = 0;
}

-(void) start{
    running = YES;
    shouldBeRunning = YES;
    
    if ( !self.stepTimer ){
        NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:0.0];
        
        NSTimer *myTimer = [[NSTimer alloc] initWithFireDate:fireDate interval:1.0 target:self selector:@selector(advance) userInfo:nil repeats:YES];
        
        self.stepTimer = myTimer;
        
        [myTimer release];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.stepTimer forMode:NSDefaultRunLoopMode];
    }
    
}
-(void) stop{
    running = NO;
    if (self.stepTimer) {
        [self.stepTimer invalidate];
        self.stepTimer = nil;
    }
}

- (void) pieceUp {
    NSLog(@"%@", self);
    
    if( !(self->antigravity) ) {
        NSLog(@"Antigravity is off");
        return;
    }
    
    if (![self currPieceWillCollideAtRow: pieceRow+1 col: pieceCol rotation: pieceRotation])
		pieceRow++;
    self.gridVersion++;
}
- (void) pieceDown {
    if (![self currPieceWillCollideAtRow: pieceRow-1 col: pieceCol rotation: pieceRotation])
		pieceRow--;
    self.gridVersion++;
}

- (NSDictionary *)currentState{
    /*
     @property(readwrite) int timeStep;
     @property(readwrite) int score;
     @property(readwrite) int height;
     @property(readonly) int width;
     
     struct TetrisPiece *currPiece;
     int pieceRow, pieceCol, pieceRotation;
     BOOL gameOver;
     BOOL running;
    */
    
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init ] autorelease];
    
    [dict setObject:grid forKey: @"grid"];
    
    [dict setObject:[NSNumber numberWithInt:self.timeStep] forKey: @"timeStep"];
    [dict setObject:[NSNumber numberWithInt:self.score] forKey: @"score"];
    [dict setObject:[NSNumber numberWithInt:self.height] forKey: @"height"];
    
    [dict setObject:[NSNumber numberWithInt:pieceRow] forKey: @"pieceRow"];
    [dict setObject:[NSNumber numberWithInt:pieceCol] forKey: @"pieceCol"];
    [dict setObject:[NSNumber numberWithInt:pieceRotation] forKey: @"pieceRotation"];
    
    if (currPiece != nil) {
        [dict setObject:[NSNumber numberWithInt:currPiece->name] forKey: @"currPiece"];
    }
    
    [dict setObject:[NSNumber numberWithBool:gameOver] forKey: @"gameOver"];
    [dict setObject:[NSNumber numberWithBool:running] forKey: @"running"];
    
    return dict;
}

- (BOOL) isRunning{
    return running;
}

- (UIColor *)getCurrPieceColor{
    if (currPiece == nil) {
        return [UIColor whiteColor];
    }
    
    switch (currPiece->name) {
        case ITetromino:
            return [UIColor cyanColor];
            break;
        case JTetromino:
            return [UIColor blueColor];
            break;
        case LTetromino:
            return [UIColor orangeColor];
            break;
        case OTetromino:
            return [UIColor yellowColor];
            break;
        case STetromino:
            return [UIColor greenColor];
            break;
        case TTetromino:
            return [UIColor purpleColor];
            break;
        case ZTetromino:
            return [UIColor redColor];
            break;
        default:
            return [UIColor blackColor];
            break;
    }
}

@end
