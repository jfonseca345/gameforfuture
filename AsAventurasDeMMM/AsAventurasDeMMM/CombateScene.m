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
#define CARD_DISTANCE 60
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
    [self setup];
}

- (void)setup
{
    self.combatController = [[CardCombatController alloc] init];
    
    self.P1HandView = [self handSpriteWithArray:self.combatController.playerHand];
    self.P2HandView = [self handSpriteWithArray:self.combatController.monsterHand];
    [self setAnchorPoint:CGPointMake(0.5, 0.5)];
    
    [self.P1HandView setPosition:CGPointMake(-self.frame.size.width/2 + 128/2, -self.frame.size.height/2 + CARD_DISTANCE*4)];
    [self.P2HandView setPosition:CGPointMake(self.frame.size.width/2 - 128/2, -self.frame.size.height/2 + CARD_DISTANCE*4)];
    
    [self addChild:self.P1HandView];
    [self addChild:self.P2HandView];
    
//    self.P1Avatar = [self avatarWithImage:self.tile1.texture];
    self.P1Avatar = [self avatarWithImage:((SKSpriteNode *)self.P1HandView.children[0]).texture];
    [self.P1Avatar setPosition:CGPointMake(((SKSpriteNode *)self.P1HandView.children[0]).position.x, self.frame.size.height/2 - self.P1Avatar.size.height/2)];
    self.P2Avatar = [self avatarWithImage:self.tile2.texture];
    [self.P2Avatar setPosition:CGPointMake(((SKSpriteNode *)self.P2HandView.children[0]).position.x, self.frame.size.height/2 - self.P1Avatar.size.height/2)];
    
    [self addChild:self.P1Avatar];
    [self addChild:self.P2Avatar];
}

- (SKSpriteNode * )avatarWithImage:(SKTexture *)image
{
    SKSpriteNode * avatar = [[SKSpriteNode alloc] initWithTexture:image color:nil size:CGSizeMake(120, 120)];
    [avatar setAnchorPoint:CGPointMake(0.5, 0.5)];
    [avatar setScale:2];
    return avatar;
}
- (SKNode * )handSpriteWithArray:(NSArray *)hand
{
    int i;
    SKNode * retHand = [[SKNode alloc] init];
    NSUInteger count = [hand count];
    int startingPoint = (CARD_DISTANCE/2) * (int)count;
    for (i = 0; i < count; i++)
    {
        SKSpriteNode * newNode = [CardSpriteFactory CardNodeWithNumber:[(CardContainer *)[hand objectAtIndex:i] number] andSuit:[(CardContainer *)[hand objectAtIndex:i] suit]];
        [newNode setPosition:CGPointMake(newNode.position.x, startingPoint)];
        [retHand addChild:newNode];
        startingPoint -= CARD_DISTANCE;
    }
    if (count == 0)
    {
        startingPoint = (CARD_DISTANCE/2) * 5;
        for (i = 0; i < 5; i++)
        {
            SKSpriteNode * newNode = [CardSpriteFactory CardNodeWithNumber:-1 andSuit:0];
            [newNode setScale:2];
            [newNode setPosition:CGPointMake(newNode.position.x, startingPoint)];
            [retHand addChild:newNode];
            startingPoint -= CARD_DISTANCE;
        }
    }
    return retHand;
}
- (void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
}

@end