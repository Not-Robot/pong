//
//  Game.m
//  AppScaffold
//

#import "Game.h"
#import "Ball.h"
#import "Paddle.h"

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)setup;
- (void)onImageTouched:(SPTouchEvent *)event;
- (void)onResize:(SPResizeEvent *)event;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation Game
{
    SPSprite *_contents;
    Ball *mBall;
    SPQuad *mBackground;
    Paddle *mPaddleL;
    SPQuad *mPaddleR;
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
    mBall.x = mBackground.width/2-mBall.width/2;
    mBall.y = mBackground.height/2-mBall.height/2;
    [self addChild:mBall];
    
    mPaddleL = [[Paddle alloc] init];
    mPaddleL.x = 0;
    [self addChild:mPaddleL];
    
    mPaddleR = [[Paddle alloc] init];
    mPaddleR.x = mBackground.width-mPaddleR.width;
    [self addChild:mPaddleR];

    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    [self addEventListener:@selector(onRightLoss:) atObject:self forType:EVENT_TYPE_RIGHT_LOSS];
    [self addEventListener:@selector(onLeftLoss:) atObject:self forType:EVENT_TYPE_LEFT_LOSS];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event {
    BOOL hitLeft = [mBall.bounds intersectsRectangle:mPaddleL.bounds];
    BOOL hitRight = [mBall.bounds intersectsRectangle:mPaddleR.bounds];
    
    if (hitLeft || hitRight) {
        [mBall paddled];
    }
}

- (void)onRightLoss:(SPEvent *)event {
    NSLog(@"Right side lost this point.");
}

- (void)onLeftLoss:(SPEvent *)event {
    NSLog(@"Left side lost this point.");
}

- (void)updateLocations
{
    int gameWidth  = Sparrow.stage.width;
    int gameHeight = Sparrow.stage.height;
    
    _contents.x = (int) (gameWidth  - _contents.width)  / 2;
    _contents.y = (int) (gameHeight - _contents.height) / 2;
}

- (void)onImageTouched:(SPTouchEvent *)event
{
    NSSet *touches = [event touchesWithTarget:self andPhase:SPTouchPhaseEnded];
    if ([touches anyObject]) [Media playSound:@"sound.caf"];
}

- (void)onResize:(SPResizeEvent *)event
{
    NSLog(@"new size: %.0fx%.0f (%@)", event.width, event.height, 
          event.isPortrait ? @"portrait" : @"landscape");
    
    [self updateLocations];
}

@end
