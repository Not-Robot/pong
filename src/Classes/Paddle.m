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
    [self addEventListener:@selector(onPaddleTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void)onPaddleTouched:(SPTouchEvent * )event {
    SPTouch *touch = [[event.touches allObjects] objectAtIndex:0];
    SPPoint *localTouchPosition = [touch locationInSpace:self.parent];
    self.y = localTouchPosition.y;
}



@end
