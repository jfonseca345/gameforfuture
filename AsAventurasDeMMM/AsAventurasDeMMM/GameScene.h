//
//  GameScene.h
//  AsAventurasDeMMM
//

//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AnalogGesture.h"
#import "buttonPad.h"


@interface GameScene : SKScene <buttonPadDelegate>

@property (nonatomic) BOOL walking;
@property (nonatomic) analogDirectionTypes heroDirection;
@property (nonatomic) CGPoint heroPosition;

@property bool firstLoad;

-(void) updateHero;
@end
