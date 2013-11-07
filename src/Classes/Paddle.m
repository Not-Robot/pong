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
        direction = (direction > 0 ? 1 : -1);
        float distance = self.y + direction * PONG_PADDLE_VELOCITY * deltaTime;
        if (direction < 0) {
            if (distance + (direction * self.height/2) > 0) {
                self.y = distance;
            } else {
                self.y = self.height/2;
            }
        } else {
            if (distance + (direction * self.height/2) < Sparrow.stage.height) {
                self.y = distance;
            } else {
                self.y = Sparrow.stage.height - self.height/2;
            }
        }
    }
}
@end
