//
//  AIController.m
//  Pong
//
//  Created by Games on 11/05/13.
//
//

#import "AIController.h"

@implementation AIController {
    Paddle *mPaddle;
    Ball   *mBall;
}

- (id)init: (Paddle * )paddle WithBall:(Ball *)ball {
    mPaddle = paddle;
    mBall   = ball;
    return self;
}

- (void)dealloc {
    // release any resources here
}

- (void)think:(float)deltaTime {
    [mPaddle move:mBall.y];
}
@end
