//
//  TetrisEngine.h
//  R1
//
//  Created by John Bellardo on 3/8/11.
//  Copyright 2011 California State Polytechnic University, San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NoTetromino 0
#define ITetromino 1
#define JTetromino 2
#define LTetromino 3
#define OTetromino 4
#define STetromino 5
#define TTetromino 6
#define ZTetromino 7

#define TetrisNumCols 10
#define TetrisArrSize(rows) ( (rows) * TetrisNumCols )
#define TetrisArrIdx(row, col) ( (row) * TetrisNumCols + (col) )

@interface TetrisEngine : NSObject {
@public
    BOOL shouldBeRunning;
    BOOL antigravity;
@private
	NSMutableArray *grid;
	struct TetrisPiece *currPiece;
	int pieceRow, pieceCol, pieceRotation;
	BOOL gameOver;
    BOOL running;
}

@property(readwrite) int timeStep;
@property(readwrite) int score;
@property(readwrite) int height;
@property(readonly) int width;
@property(readwrite) int gridVersion;

@property(readwrite, retain) NSTimer *stepTimer;

- (id) init;
- (id) initWithHeight: (int) height;
- (id) initWithState:(NSDictionary *)state;
- (int) height;
- (int) width;
- (int) timeStep;
- (int) score;

- (void) start;
- (void) stop;

- (void) pieceUp;
- (void) pieceDown;
- (void) slideLeft;
- (void) slideRight;
- (void) rotateCW;
- (void) rotateCCW;
- (void) reset;

- (int) pieceAtRow: (int) row column: (int)col;
- (void) nextPiece;
- (void) commitCurrPiece;
- (BOOL) currPieceWillCollideAtRow: (int) row col: (int) col rotation: (int) rot;
- (BOOL) currPieceOffGrid;

- (UIColor *)getCurrPieceColor;

- (BOOL) isRunning;

- (NSDictionary *)currentState;

@end
