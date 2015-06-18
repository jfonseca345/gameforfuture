//
//  CombateScene.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/18/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "CombateScene.h"
#import "CardCombatController.h"
#import "CardSpriteFactory.h"
#import "CardContainer.h"

@interface CombateScene()

@property SKSpriteNode * P1Avatar;
@property SKSpriteNode * P2Avatar;

@property SKNode * P1HandView;
@property SKNode * P2HandView;

@property SKNode * DeckView;
@property SKNode * Table;

@property CardCombatController * combatController;

@end

@implementation CombateScene

-(void)didMoveToView:(SKView *)view
{
    
}

- (void)setup
{
    self.combatController = [[CardCombatController alloc] init];
    
    self.P1HandView = [self handSpriteWithArray:self.combatController.playerHand];
    self.P2HandView = [self handSpriteWithArray:self.combatController.monsterHand];
    
    [self.P1HandView setPosition:CGPointMake(10, 10)];
    [self.P2HandView setPosition:CGPointMake(-10, -10)];
    
    [self addChild:self.P1HandView];
    [self addChild:self.P2HandView];
}

- (SKSpriteNode * )avatarWithImage:(SKSpriteNode *)image
{
    SKSpriteNode * avatar = [[SKSpriteNode alloc] initWithTexture:image.texture color:[UIColor whiteColor] size:CGSizeMake(60, 60)];
    return avatar;
}
- (SKNode * )handSpriteWithArray:(NSArray *)hand
{
    int i;
    SKNode * retHand = [[SKNode alloc] init];
    NSUInteger count = [hand count];
    unsigned long startingPoint = -5 * count;
    for (i = 0; i < count; i++)
    {
        SKNode * newNode = [CardSpriteFactory CardNodeWithNumber:[(CardContainer *)[hand objectAtIndex:i] number] andSuit:[(CardContainer *)[hand objectAtIndex:i] suit]];
        [newNode setPosition:CGPointMake(startingPoint, newNode.position.y)];
        [retHand addChild:newNode];
        startingPoint += 5;
    }
    return retHand;
}

@end
