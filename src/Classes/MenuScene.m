//
//  MenuScene.m
//  Pong
//
//  Created by Games on 11/2/13.
//
//

#import "MenuScene.h"
#import "Game.h"

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
    
    SPTexture *emptyButton = [[SPTexture alloc] initWithWidth:300 height:60 draw:^(CGContextRef context) {}];
    SPButton *start = [SPButton buttonWithUpState:emptyButton text:@"Start"];
    start.fontColor = 0xFFFFFF;
    start.textBounds = [SPRectangle rectangleWithX:start.textBounds.x y:(start.textBounds.y + 5) width:start.textBounds.width height:start.textBounds.height];
    start.y = 200;
    [start addEventListener:@selector(startGame:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [self addChild:start];
}

- (void)startGame:(SPEvent *)event {
    //[(Game *)[SPStage mainStage] showGameScene];
    [(Game *)self.parent showGameScene];
}

@end
