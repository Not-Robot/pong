//
//  Paddle.m
//  Pong
//
//  Created by Games on 10/28/13.
//
//

#import "Paddle.h"

@implementation Paddle {

}

- (id)init {
    if ((self = [super initWithWidth:10 height:60 color:0xFFFFFF]))
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
    self.y = Sparrow.stage.height/2;
    self.pivotY    = self.height/2;
    self.pivotX    = self.width/2;
    self.mPosition = self.y;
}

- (void)move:(int)position {
    self.mPosition = position;
}

- (void)think:(float)deltaTime {
    int direction = self.mPosition - self.y;
    if (abs(direction) > PONG_PADDLE_DEADZONE) {
        self.y += (direction > 0 ? 1 : -1) * PONG_PADDLE_VELOCITY * deltaTime;
    }
}
@end
