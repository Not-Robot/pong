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
#import "Ball.h"
#import "ScoreBoard.h"
#import "SimpleButton.h"
#import "Game.h"

@interface GameScene ()

- (void)setup;

@end

@implementation GameScene
{
    SPSprite *_contents;
    Ball *mBall;
    SPQuad *mBackground;
    Paddle *mPaddleL;
    Paddle *mPaddleR;
    PaddleController *mPCtlL;
    PaddleController *mPCtlR;
    ScoreBoard *mScoreBoard;
    int mLeftScore;
    int mRightScore;
    BOOL mHasAI;
    int mPaddleVel;
}

- (id)init {
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    // release any resources here
    [Media releaseAtlas];
    [Media releaseSound];
}

- (void)setup {
    mBackground = [[SPQuad alloc] initWithWidth:Sparrow.stage.width height:Sparrow.stage.height color:0x000000];
    [self addChild:mBackground];
    mBall = [[Ball alloc] init];
    mBall.x = mBackground.width/2;
    mBall.y = mBackground.height/2;
    [self addChild:mBall];
    
    mPaddleL = [[Paddle alloc] init];
    mPaddleL.x = mPaddleL.width/2;
    [self addChild:mPaddleL];

    mPCtlL   = [[PaddleController alloc] init:mPaddleL];
    mPCtlL.x = mPCtlL.width/2;
    [self addChild:mPCtlL];
    
    mPaddleR = [[Paddle alloc] init];
    mPaddleR.x = mBackground.width-mPaddleR.width/2;
    [self addChild:mPaddleR];
    
    mPCtlR   = [[PaddleController alloc] init:mPaddleR];
    mPCtlR.x = mBackground.width-mPCtlR.width/2;
    [self addChild:mPCtlR];

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
    
    [self setAI:NO];
    
    mPaddleVel = 70;
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    [self addEventListener:@selector(onRightLoss:) atObject:self forType:EVENT_TYPE_RIGHT_LOSS];
    [self addEventListener:@selector(onLeftLoss:) atObject:self forType:EVENT_TYPE_LEFT_LOSS];
}

- (void)setAI:(BOOL)hasAI {
    mHasAI = hasAI;
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
    
    if (mHasAI) {
        int dir = mBall.y-mPaddleR.y;
        if (mPaddleR.y > mPaddleR.height/2 || mPaddleR.y < mBackground.height-mPaddleR.height/2) {
            if (dir > 0) {
                mPaddleR.y += mPaddleVel*event.passedTime;
            } else if (dir < 0) {
                mPaddleR.y -= mPaddleVel*event.passedTime;
            }
        }
    }

    [mPaddleR think:event.passedTime];
    [mPaddleL think:event.passedTime];
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
