//
//  PaddleController.h
//  Pong
//
//  Created by Games on 11/05/13.
//
//

#import <Foundation/Foundation.h>
#import "Paddle.h"
#import "Ball.h"
#import "Thinker.h"

@interface AIController : NSObject <Thinker>
    - (id)init: (Paddle *)paddle WithBall:(Ball *)ball;
@end
