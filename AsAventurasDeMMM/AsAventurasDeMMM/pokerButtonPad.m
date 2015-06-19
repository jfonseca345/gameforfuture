//
//  pokerButtonPad.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "pokerButtonPad.h"

#define BKG_WIDTH 80
#define BKG_HEIGHT 40

@interface pokerButtonPad()

@property SKSpriteNode * theAButton;
@property SKSpriteNode * theBButton;
@property SKSpriteNode * theCButton;
@property SKSpriteNode * background;
@property SKNode * selected;

@end

@implementation pokerButtonPad

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
        self.theAButton.name = @"Pbutton1";
        self.theBButton = [[SKSpriteNode alloc] initWithImageNamed:@"Button2"];
        [self.theBButton setScale:1.5];
        self.theBButton.name = @"Pbutton2";
        self.theCButton = [[SKSpriteNode alloc] initWithImageNamed:@"Button1"];
        [self.theCButton setScale:1.5];
        self.theCButton.name = @"Pbutton3";
        
        [self addChild: self.background];
        
        [self.theBButton setPosition:CGPointMake(0 + 2*self.theBButton.size.width/2 + 10, 0)];
        [self.theCButton setPosition:CGPointMake(0 - 2*self.theAButton.size.width/2 - 10, 0)];
        
        [self.background addChild:self.theAButton];
        [self.background addChild:self.theCButton];
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
    else if ([self.selected isEqual:self.theCButton])
    {
        [self.delegate cButtonTapped];
    }
    
}

@end
