//
//  GameScene.m
//  Pong
//
//  Created by Games on 11/2/13.
//
//

#import "GameScene.h"
#import "Paddle.h"
#import "PaddleController.h"
#import "AIController.h"
#import "Ball.h"
#import "ScoreBoard.h"
#import "SimpleButton.h"
#import "Game.h"

@interface GameScene ()

    - (void)setup:(bool)hasAI;

@end

@implementation GameScene {
    SPSprite *_contents;
    Ball *mBall;
    SPQuad *mBackground;
    Paddle *mPaddleL;
    Paddle *mPaddleR;
    ScoreBoard *mScoreBoard;
    int mLeftScore;
    int mRightScore;

    NSMutableArray *mThinkers;
}

- (id)init:(BOOL)hasAI {
    if ((self = [super init]))
    {
        [self setup:hasAI];
    }
    return self;
}

- (void)dealloc {
    // release any resources here
    [Media releaseAtlas];
    [Media releaseSound];
}

- (void)setup:(bool)hasAI {
    mBackground = [[SPQuad alloc] initWithWidth:Sparrow.stage.width height:Sparrow.stage.height color:0x000000];
    [self addChild:mBackground];

    mThinkers = [NSMutableArray array];

    mBall = [[Ball alloc] init];
    mBall.x = mBackground.width/2;
    mBall.y = mBackground.height/2;
    [self addChild:mBall];
    
    mPaddleL = [[Paddle alloc] init];
    mPaddleL.x = mPaddleL.width/2;
    [self addChild:mPaddleL];
    [mThinkers addObject:mPaddleL];

    PaddleController *mPCtlL;
    mPCtlL   = [[PaddleController alloc] init:mPaddleL];
    mPCtlL.x = mPCtlL.width/2;
    [self addChild:mPCtlL];
    
    mPaddleR = [[Paddle alloc] init];
    mPaddleR.x = mBackground.width-mPaddleR.width/2;
    [self addChild:mPaddleR];
    [mThinkers addObject:mPaddleR];
    
    if (hasAI) {
        AIController *mAICtlR;
        mAICtlR = [[AIController alloc] init:mPaddleR WithBall:mBall];
        [mThinkers addObject:mAICtlR];
    } else {
        PaddleController *mPCtlR;
        mPCtlR   = [[PaddleController alloc] init:mPaddleR];
        mPCtlR.x = mBackground.width-mPCtlR.width/2;
        [self addChild:mPCtlR];
    }

    mScoreBoard = [[ScoreBoard alloc] init];
    mScoreBoard.x = mBackground.width/2;
    mScoreBoard.y = mScoreBoard.height/2;
    [self addChild:mScoreBoard];
    mLeftScore = 0;
    mRightScore = 0;
    [self setScoreText];
    
    SimpleButton *quit = [[SimpleButton alloc] init];
    quit.text = @"Quit";
    quit.y = quit.height;
    quit.x = mBackground.width-quit.width*2;
    [quit addEventListener:@selector(quitGame:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [self addChild:quit];
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    [self addEventListener:@selector(onRightLoss:) atObject:self forType:EVENT_TYPE_RIGHT_LOSS];
    [self addEventListener:@selector(onLeftLoss:) atObject:self forType:EVENT_TYPE_LEFT_LOSS];
}

- (void)setScoreText {
    NSString *newText = [NSString stringWithFormat:@"%i | %i", mLeftScore, mRightScore];
    mScoreBoard.text = newText;
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event {
    BOOL hitLeft = [mBall.bounds intersectsRectangle:mPaddleL.bounds];
    BOOL hitRight = [mBall.bounds intersectsRectangle:mPaddleR.bounds];
    
    if (hitLeft || hitRight) {
        if (mBall.x < mBall.width/2+mPaddleL.width) {
            mBall.x = mBall.width+mPaddleL.width;
        } else if (mBall.x > mBackground.width-(mBall.width/2+mPaddleR.width)) {
            mBall.x = mBackground.width-(mBall.width/2+mPaddleR.width);
        }
        [mBall paddled];
    }

    for(id thinker in mThinkers) {
        [thinker think:event.passedTime];
    }
}

- (void)quitGame:(SPEvent *)event {
    [(Game *)self.parent showMenuScene];
}

- (void)onRightLoss:(SPEvent *)event {
    NSLog(@"Right side lost this point.");
    mLeftScore += 1;
    [self setScoreText];
    [self checkWin];
}

- (void)onLeftLoss:(SPEvent *)event {
    NSLog(@"Left side lost this point.");
    mRightScore += 1;
    [self setScoreText];
    [self checkWin];
}

- (void)checkWin {
    if (mLeftScore > 4) {
        [(Game *)self.parent showMenuScene];
    } else if (mRightScore > 4) {
        [(Game *)self.parent showMenuScene];
    }
}

@end
