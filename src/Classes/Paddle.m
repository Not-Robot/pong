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
    self.pivotY = self.height/2;
    self.pivotX = self.width/2;
    [self addEventListener:@selector(onPaddleTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void)onPaddleTouched:(SPTouchEvent * )event {
    SPTouch *touch = [[event.touches allObjects] objectAtIndex:0];
    SPPoint *localTouchPosition = [touch locationInSpace:self.parent];
    if (localTouchPosition.y < self.height/2) {
        self.y = self.height/2;
    } else if (localTouchPosition.y > Sparrow.stage.height-self.height/2) {
        self.y = Sparrow.stage.height-self.height/2;
    } else {
        self.y = localTouchPosition.y;
    }
}



@end
