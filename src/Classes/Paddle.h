//
//  Paddle.h
//  Pong
//
//  Created by Games on 10/28/13.
//
//

#import <Foundation/Foundation.h>
#import "Thinker.h"

#define PONG_PADDLE_VELOCITY 140
#define PONG_PADDLE_DEADZONE 5

@interface Paddle : SPQuad <Thinker>
    @property int mPosition;

    - (void)move:(int)position;
@end
