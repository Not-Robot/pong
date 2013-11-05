//
//  SimpleButton.m
//  Pong
//
//  Created by Games on 11/3/13.
//
//

#import "SimpleButton.h"

@implementation SimpleButton

- (id)init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    // release any resources here
    [Media releaseAtlas];
    [Media releaseSound];
}

- (void)setup {
    SPTexture *emptyButton = [[SPTexture alloc] initWithWidth:300 height:60 draw:^(CGContextRef context) {}];
    self.upState = emptyButton;
    self.fontColor = 0xFFFFFF;
    self.pivotX = self.width/2;
    self.pivotY = self.height/2;
    //self.textBounds = [SPRectangle rectangleWithX:self.textBounds.x y:(self.textBounds.y + 5) width:self.textBounds.width height:self.textBounds.height];
    //self.textBounds = [SPRectangle rectangleWithX:5 y:-5 width:self.width-10 height:self.height+5];
}

@end
