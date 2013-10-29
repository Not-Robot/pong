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

- (void)reset {
    // init physics stuff
    xVel = 5;
    yVel = 5;
    self.x = Sparrow.stage.width/2;
    self.y = Sparrow.stage.height/2;
}

- (void)setup {
    [self reset];
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)paddled {
    xVel=-xVel;
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
        //xVel = -xVel;
        [self reset];
        // fire off right loss
        SPEvent *lossEvent = [SPEvent eventWithType:EVENT_TYPE_RIGHT_LOSS];
        [self.parent dispatchEvent:lossEvent];
    } else if (self.x < 0) {
        //xVel = -xVel;
        [self reset];
        // fire off left loss
        SPEvent *lossEvent = [SPEvent eventWithType:EVENT_TYPE_LEFT_LOSS];
        [self.parent dispatchEvent:lossEvent];
    }
}

@end
