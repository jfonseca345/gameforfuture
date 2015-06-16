//
//  AnalogGesture.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/12/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "AnalogGesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <SpriteKit/SpriteKit.h>

@interface AnalogGesture()

@property SKSpriteNode * analogCircle;
@property SKSpriteNode * analogPos;
@property SKScene * parentScene;
@property CGPoint touchPosition;
@property CGPoint touchNow;
@end

@implementation AnalogGesture

- (instancetype)initWithTarget:(id)target action:(SEL)action scene: (SKScene *)scene
{
    self = [super initWithTarget:target action:action];
    if (self != nil)
    {
        self.analogCircle = [[SKSpriteNode alloc] initWithImageNamed:@"Outer_CrossHair"];
        self.analogPos = [[SKSpriteNode alloc] initWithImageNamed:@"Inner_CrossHair"];
        self.parentScene = scene;
    }
    return self;
}

- (void)reset
{
    [super reset];
    self.analogDirection = ANALOG_ZERO;
    [self.analogCircle removeFromParent];
    [self.analogPos removeFromParent];
    NSLog(@"Remove all");
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ([touches count] != 1)
    {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    UITouch * touch = [[event allTouches] anyObject];
    self.touchPosition = [touch locationInNode:self.parentScene];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStatePossible)
    {
        [self.analogCircle setZPosition:10];
        [self.analogPos setZPosition:10];
        [self.analogCircle setPosition:self.touchPosition];
        [self.analogPos setPosition:self.touchPosition];
        [self.parentScene addChild:self.analogCircle];
        [self.parentScene addChild:self.analogPos];
        [self.analogPos setScale:2];
        NSLog(@"Add all");
        self.state = UIGestureRecognizerStateBegan;
    }
    else
    {
        self.touchNow = [[[event allTouches] anyObject] locationInNode:self.parentScene];
        CGPoint newPosition = self.touchNow;
        CGPoint vector = CGPointMake(self.touchNow.x - self.touchPosition.x,self.touchNow.y - self.touchPosition.y);
        double transform = sqrt(vector.x*vector.x + vector.y*vector.y);
//        NSLog(@"%f<>%f<>%f<>%f",transform, vector.x, vector.y, self.analogCircle.size.height/2);
        if (transform > self.analogCircle.size.height/2)
        {
            newPosition.x = self.touchPosition.x + ((vector.x/transform) * self.analogCircle.size.height/2);
            newPosition.y = self.touchPosition.y + ((vector.y/transform) * self.analogCircle.size.height/2);
        }
        [self.analogPos setPosition: newPosition];
        int xDif = self.touchNow.x - self.touchPosition.x;
        int yDif = self.touchNow.y - self.touchPosition.y;
        if (abs(xDif) > abs(yDif))
        {
            if (xDif > 10) self.analogDirection = ANALOG_RIGHT;
            else if (xDif < -10) self.analogDirection = ANALOG_LEFT;
            else self.analogDirection = ANALOG_ZERO;
        }
        else if (abs(xDif) < abs(yDif))
        {
            if (yDif > 10) self.analogDirection = ANALOG_UP;
            else if (yDif < -10) self.analogDirection = ANALOG_DOWN;
            else self.analogDirection = ANALOG_ZERO;
        }
        else if (xDif < 10 && xDif > -10) self.analogDirection = ANALOG_ZERO;
            
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.analogDirection = ANALOG_ZERO;
    [super touchesEnded:touches withEvent:event];
    [self.analogCircle removeFromParent];
    [self.analogPos removeFromParent];
    NSLog(@"Remove all");
    self.state = UIGestureRecognizerStateEnded;
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.analogDirection = ANALOG_ZERO;
    [super touchesCancelled:touches withEvent:event];
    [self.analogCircle removeFromParent];
    [self.analogPos removeFromParent];
    NSLog(@"Remove all");
    self.state = UIGestureRecognizerStateCancelled;
}

@end
