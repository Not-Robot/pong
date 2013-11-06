//
//  GameScene.m
//  Pong
//
//  Created by Games on 11/2/13.
//
//

#import "GameScene.h"
#import "Paddle.h"
#import "Ball.h"
#import "ScoreBoard.h"

@interface GameScene ()

- (void)setup;

@end

@implementation GameScene
{
    SPSprite *_contents;
    Ball *mBall;
    SPQuad *mBackground;
    Paddle *mPaddleL;
    SPQuad *mPaddleR;
    ScoreBoard *mScoreBoard;
    int mLeftScore;
    int mRightScore;
}

- (id)init
{
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
    
    mPaddleR = [[Paddle alloc] init];
    mPaddleR.x = mBackground.width-mPaddleR.width/2;
    [self addChild:mPaddleR];
    
    mScoreBoard = [[ScoreBoard alloc] init];
    mScoreBoard.x = mBackground.width/2;
    mScoreBoard.y = mScoreBoard.height/2;
    [self addChild:mScoreBoard];
    mLeftScore = 0;
    mRightScore = 0;
    [self setScoreText];
    
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
}

- (void)onRightLoss:(SPEvent *)event {
    NSLog(@"Right side lost this point.");
    mLeftScore += 1;
    [self setScoreText];
}

- (void)onLeftLoss:(SPEvent *)event {
    NSLog(@"Left side lost this point.");
    mRightScore += 1;
    [self setScoreText];
}

@end
