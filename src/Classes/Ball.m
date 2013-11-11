//
//  Ball.m
//  Pong
//
//  Created by Games on 10/28/13.
//
//

#import "Ball.h"

@implementation Ball {
    SPPoint *mForward;
}

- (id)init {
    if ((self = [super initWithWidth:10 height:10 color:0xFFFFFF])) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    // release any resources here
}

- (void)reset {
    // init physics stuff
    self.x = Sparrow.stage.width/2;
    self.y = Sparrow.stage.height/2;
    mForward = [mForward initWithPolarLength: 1.0f angle: M_PI * 0.25f];
}

- (void)setup {
    mForward = [SPPoint alloc];
    [self reset];
    self.pivotY = self.height/2;
    self.pivotX = self.width/2;
}

- (void)collision:(SPPoint *)normal {
    // Law of Reflection
    // Solved for R in terms of vectors N and V
    // Where R is the reflected vector
    // N is the normal vector of the surface
    // V is the incoming velocity vector
    // R = V-2N(N·V)
    mForward = [mForward subtractPoint: [normal scaleBy: 2.0f * [normal dot: mForward]]];
}

- (void) think:(float)deltaTime {
    mForward = [mForward scaleBy: PONG_BALL_VELOCITY * deltaTime];
    self.x += mForward.x;
    self.y += mForward.y;
    mForward = [mForward normalize];
}

@end
