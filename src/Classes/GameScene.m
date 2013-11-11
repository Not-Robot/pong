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
    [mThinkers addObject:mBall];
    
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
}

- (void)setScoreText {
    NSString *newText = [NSString stringWithFormat:@"%i | %i", mLeftScore, mRightScore];
    mScoreBoard.text = newText;
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event {
    // This is starting to get beefy.  This block of code
    // may be out of place, but it houses all collisions checks
    // between all objects in our scene.  Because we are not using
    // a physics engine, there would be too much dependancy
    // injection going on to not have these collisions checks in
    // a central location.  For that reason, they are all housed
    // within the GameScene that contains all these objects anyway.
    //
    // This could be simplified by using a raycasting method in
    // which the ball would look at it's next location with it's
    // velocity ray.  If that ray intersected any object we could
    // then use the normal from the point it struck and we would
    // be done.  Sparrow, however, has poor support for vectors.
    // While this is not impossible, such optimizations are not
    // worth the investment.
    if ([mBall.bounds intersectsRectangle:mPaddleL.bounds]) {
        mBall.x = mPaddleL.bounds.right + mBall.width/2;
        [mBall collision: [SPPoint pointWithPolarLength: 1.0f angle: 0.0f]];
    } else if ([mBall.bounds intersectsRectangle:mPaddleR.bounds]) {
        mBall.x = mPaddleR.bounds.left - mBall.width/2;
        [mBall collision: [SPPoint pointWithPolarLength: 1.0f angle: M_PI]];
    } else if (![mBackground.bounds containsRectangle: mBall.bounds]) {
        if (mBall.bounds.top < mBackground.bounds.top) {
            [mBall collision: [SPPoint pointWithPolarLength: 1.0f angle: M_PI * 0.5f]];
        } else if (mBall.bounds.bottom > mBackground.bounds.bottom) {
            [mBall collision: [SPPoint pointWithPolarLength: 1.0f angle: M_PI * 1.5f]];
        } else if (mBall.bounds.left < mBackground.bounds.left) {
            [mBall reset];
            [self onLeftLoss];
        } else if (mBall.bounds.right > mBackground.bounds.right) {
            [mBall reset];
            [self onRightLoss];
        }
    }

    for(id thinker in mThinkers) {
        [thinker think:event.passedTime];
    }
}

- (void)quitGame:(SPEvent *)event {
    [(Game *)self.parent showMenuScene];
}

- (void)onRightLoss{
    NSLog(@"Right side lost this point.");
    mLeftScore += 1;
    [self setScoreText];
    [self checkWin];
}

- (void)onLeftLoss{
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
