//
//  Ball.m
//  Pong
//
//  Created by Games on 10/28/13.
//
//

#import "Ball.h"

@implementation Ball {

    float xVel;
    float yVel;
}

- (id)init {
    if ((self = [super initWithWidth:10 height:10 color:0xFFFFFF]))
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    // release any resources here
    
}

- (void)setup {
    // init physics stuff
    xVel = 5;
    yVel = 5;
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void) onEnterFrame:(SPEnterFrameEvent *)event {
    self.x += xVel;
    self.y += yVel;
    
    if (self.y > Sparrow.stage.height-self.height) {
        yVel = -yVel;
        self.y = Sparrow.stage.height-self.height;
    } else if (self.y < 0) {
        yVel = -yVel;
        self.y = 0;
    }
    
    if (self.x > Sparrow.stage.width-self.width) {
        xVel = -xVel;
        self.x = Sparrow.stage.width-self.width;
    } else if (self.x < 0) {
        xVel = -xVel;
        self.x = 0;
    }
}

@end
