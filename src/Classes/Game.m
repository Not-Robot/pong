//
//  Game.m
//  AppScaffold
//

#import "Game.h"
#import "GameScene.h"
#import "MenuScene.h"

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)setup;
- (void)onImageTouched:(SPTouchEvent *)event;
- (void)onResize:(SPResizeEvent *)event;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation Game
{
    SPSprite *mCurrentScene;
    GameScene *mGameScene;
    MenuScene *mMenuScene;
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
    mGameScene = [[GameScene alloc] init];
    //[self showScene:gameScene];
    
    mMenuScene = [[MenuScene alloc] init];
    [self showScene:mMenuScene];
    
    [self addEventListener:@selector(onResize:) atObject:self forType:SP_EVENT_TYPE_RESIZE];
}

//- (void)startGame:(SPEvent *)event {
 //   [self showScene:mGameScene];
//}

- (void)showScene:(SPSprite *)scene {
    if ([self containsChild:mCurrentScene]) {
        [self removeChild:mCurrentScene];
    }
    [self addChild:scene];
    mCurrentScene = scene;
}

- (void)showGameScene {
    [self showScene:mGameScene];
}

- (void)updateLocations
{
//    int gameWidth  = Sparrow.stage.width;
//    int gameHeight = Sparrow.stage.height;
    
//    _contents.x = (int) (gameWidth  - _contents.width)  / 2;
 //   _contents.y = (int) (gameHeight - _contents.height) / 2;
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
