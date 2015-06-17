//
//  buttonPad.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/16/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#define BKG_WIDTH 60
#define BKG_HEIGHT 40
#import "buttonPad.h"

@interface buttonPad()

@property SKSpriteNode * theAButton;
@property SKSpriteNode * theBButton;
@property SKSpriteNode * background;
@property SKNode * selected;

@end

@implementation buttonPad

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setZPosition:9];
        
        self.background = [[SKSpriteNode alloc] initWithColor:nil size:CGSizeMake(BKG_WIDTH, BKG_HEIGHT)];
        [self.background setAnchorPoint:CGPointMake(0.5, 0.5)];
        self.theAButton = [[SKSpriteNode alloc] initWithImageNamed:@"Button1"];
        [self.theAButton setScale:1.5];
        self.theAButton.name = @"button1";
        self.theBButton = [[SKSpriteNode alloc] initWithImageNamed:@"Button2"];
        [self.theBButton setScale:1.5];
        self.theBButton.name = @"button2";
        [self addChild: self.background];
        
        [self.theBButton setPosition:CGPointMake(0 + self.theBButton.size.width/2 + 10, 0)];
        [self.theAButton setPosition:CGPointMake(0 - self.theAButton.size.width/2 - 10, 0)];
        
        [self.background addChild:self.theAButton];
        [self.background addChild:self.theBButton];
        
        [self setUserInteractionEnabled:YES];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touch = [[[event allTouches] anyObject] locationInNode:self];
    self.selected = [self nodeAtPoint:touch];
    if ([self.selected isEqual:self.theBButton])
    {
        [self.delegate bButtonTapped];
    }
    else if ([self.selected isEqual:self.theAButton])
    {
        [self.delegate aButtonTapped];
    }
    
}

- (CGPoint)size
{
    CGPoint mySize;
    mySize = CGPointMake(BKG_WIDTH, BKG_HEIGHT);
    return mySize;
}

@end
