//
//  Ball.h
//  Pong
//
//  Created by Games on 10/28/13.
//
//

#import <Foundation/Foundation.h>

#define EVENT_TYPE_RIGHT_LOSS @"rightLoss"
#define EVENT_TYPE_LEFT_LOSS @"leftLoss"

@interface Ball : SPQuad

- (void)paddled;

@end
