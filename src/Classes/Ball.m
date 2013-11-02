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
    xVel = 80;
    yVel = 80;
    self.x = Sparrow.stage.width/2;
    self.y = Sparrow.stage.height/2;
}

- (void)setup {
    [self reset];
    self.pivotY = self.height/2;
    self.pivotX = self.width/2;
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)paddled {
    xVel=-xVel;
}

- (void) onEnterFrame:(SPEnterFrameEvent *)event {
    self.x += xVel*event.passedTime;
    self.y += yVel*event.passedTime;
    
    if (self.y > Sparrow.stage.height-self.height/2) {
        yVel = -yVel;
        self.y = Sparrow.stage.height-self.height/2;
    } else if (self.y < self.height/2) {
        yVel = -yVel;
        self.y = self.height/2;
    }
    
    if (self.x > Sparrow.stage.width-self.width/2) {
        //xVel = -xVel;
        [self reset];
        // fire off right loss
        [self dispatchEvent:[SPEvent eventWithType:EVENT_TYPE_RIGHT_LOSS bubbles:YES]];
    } else if (self.x < self.width/2) {
        //xVel = -xVel;
        [self reset];
        // fire off left loss
        [self dispatchEvent:[SPEvent eventWithType:EVENT_TYPE_LEFT_LOSS bubbles:YES]];
    }
}

@end
