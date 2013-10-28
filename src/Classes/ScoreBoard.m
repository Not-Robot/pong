//
//  ScoreBoard.m
//  Pong
//
//  Created by Games on 10/27/13.
//
//

#import "ScoreBoard.h"

@implementation ScoreBoard

- (id)init
{
    if ((self = [super initWithWidth:100 height:40]))
    {
        [self setup];
    }
    return self;
}
- (void)setup {
    self.pivotY = self.height/2;
    self.pivotX = self.width/2;
    self.color = 0xFFFFFF;
    self.hAlign = SPHAlignCenter;
    self.vAlign = SPVAlignCenter;
    self.fontSize = 22;
}

@end
