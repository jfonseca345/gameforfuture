//
//  GameScene.h
//  AsAventurasDeMMM
//

//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AnalogGesture.h"


@interface GameScene : SKScene

@property (nonatomic) BOOL walking;
@property (nonatomic) analogDirectionTypes heroDirection;
@property (nonatomic) CGPoint heroPosition;

-(void) updateHero;
@end
