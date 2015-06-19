//
//  CombateScene.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/18/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AsAventurasDeMMM-Swift.h"

@interface CombateScene : SKScene

- (instancetype)initWithSize:(CGSize)size andWithHero:(Hero *)myHero andMonster:(Monster *) myMonster;
- (void) updateHandsWithHeroHand:(NSMutableArray *)heroHand andMonsterHand:(NSMutableArray *)monsterHand;

@property Hero * player1;
@property Monster * player2;

@property HeroTile * tile1;
@property MonsterTile *tile2;

@end
