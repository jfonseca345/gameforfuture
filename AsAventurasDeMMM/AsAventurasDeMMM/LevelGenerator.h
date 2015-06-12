//
//  LevelGenerator.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/10/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LevelGenerator : SKShapeNode
+ (NSArray *) randomizeLevel:(int)levelNumber withWeak:(int)weakCount medium:(int)mediumCount strong:(int)strongCount;
@end
