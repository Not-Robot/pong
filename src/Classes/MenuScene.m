//
//  MenuScene.m
//  Pong
//
//  Created by Games on 11/2/13.
//
//

#import "MenuScene.h"
#import "Game.h"
#import "SimpleButton.h"

@implementation MenuScene
{
    SPSprite *mCurrentScene;
    SPQuad *mBackground;
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
    
    mBackground = [[SPQuad alloc] initWithWidth:Sparrow.stage.width height:Sparrow.stage.height color: 0x000000];
    [self addChild:mBackground];
    
    SPTextField *title = [[SPTextField alloc] init];
    title.text = @"Welcome to Pong";
    title.color = 0xFFFFFF;
    title.pivotX = title.width/2;
    title.x = mBackground.width/2;
    [self addChild:title];
    
    SimpleButton *single = [[SimpleButton alloc] init];
    single.text = @"Solo";
    single.y = 200;
    single.x = mBackground.width/2;
    [single addEventListener:@selector(startSingle:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [self addChild:single];
    
    SimpleButton *multi = [[SimpleButton alloc] init];
    multi.text = @"Multi";
    multi.y = 300;
    multi.x = mBackground.width/2;
    [multi addEventListener:@selector(startMulti:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [self addChild:multi];
}

- (void)startSingle:(SPEvent *)event {
    [(Game *)self.parent showGameScenewithAI:YES];
}

- (void)startMulti:(SPEvent *)event {
    [(Game *)self.parent showGameScenewithAI:NO];
}

@end
