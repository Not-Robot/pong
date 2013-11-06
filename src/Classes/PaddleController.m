//
//  PaddleController.m
//  Pong
//
//  Created by Games on 11/05/13.
//
//

#import "PaddleController.h"
#import "Paddle.h"

@implementation PaddleController {
	Paddle *mPaddle;
}

- (id)init:(Paddle * )paddle {
    if ((self = [super initWithWidth:Sparrow.stage.width/2 height:Sparrow.stage.height color:0xFFFFFF]))
    {
        [self setup];
        mPaddle = paddle;
    }
    return self;
}

- (void)dealloc
{
    // release any resources here
    
}

- (void)setup {
    self.y = Sparrow.stage.height/2;
    self.pivotY = self.height/2;
    self.pivotX = self.width/2;
    self.alpha  = 0;
    [self addEventListener:@selector(onControllerTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void)onControllerTouched:(SPTouchEvent * )event {
    SPTouch *touch = [[event.touches allObjects] objectAtIndex:0];
    if (touch.phase == SPTouchPhaseEnded) {
        [mPaddle move:mPaddle.y];
    } else {
        [mPaddle move:touch.globalY];
    }
}
@end
