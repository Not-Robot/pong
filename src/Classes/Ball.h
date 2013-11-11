//
//  Ball.h
//  Pong
//
//  Created by Games on 10/28/13.
//
//

#import <Foundation/Foundation.h>
#import "Thinker.h"

#define PONG_BALL_VELOCITY 120

@interface Ball : SPQuad <Thinker>

- (void)collision:(SPPoint *)normal;
- (void)reset;

@end
