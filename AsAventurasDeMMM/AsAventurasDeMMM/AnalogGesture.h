//
//  AnalogGesture.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/12/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <SpriteKit/SpriteKit.h>

@interface AnalogGesture : UIGestureRecognizer

typedef NS_ENUM(NSInteger, analogDirectionTypes)
{
    ANALOG_UP,
    ANALOG_DOWN,
    ANALOG_LEFT,
    ANALOG_RIGHT,
    ANALOG_ZERO,
};

@property analogDirectionTypes analogDirection;

- (instancetype)initWithTarget:(id)target action:(SEL)action scene: (SKScene *)scene;
- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
