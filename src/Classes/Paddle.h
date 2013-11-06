//
//  Paddle.h
//  Pong
//
//  Created by Games on 10/28/13.
//
//

#import <Foundation/Foundation.h>

#define PONG_PADDLE_VELOCITY 140
#define PONG_PADDLE_DEADZONE 5

@interface Paddle : SPQuad
    @property int mPosition;

    - (void)move:(int)position;
    - (void)think:(float)deltaTime;
@end
