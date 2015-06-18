//
//  CardCombatController.h
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 16/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deck.h"
#import "CombatState.h"
#import "CardContainer.h"
#import "AsAventurasDeMMM-Swift.h"

@interface CardCombatController : NSObject

#pragma mark Players Attributes

@property (nonatomic) Hero* player;
@property (nonatomic) Monster* monster;


#pragma mark Deck Manipulation Methods and Attributes

@property (strong, nonatomic) NSMutableArray* deck;
@property int drawCounter;

-(CardContainer*) drawCard;
-(void) shuffleCards;

#pragma mark Hand Atributes
@property (strong, nonatomic) NSMutableArray* playerHand;
@property (strong, nonatomic) NSMutableArray* monsterHand;

#pragma mark Game Managements Methods and Attributes

@property int pot;

-(void) prepareGame: (Hero*)withHero : (Monster*)andMonster;
-(void) prepareRound;
-(void) tradeCards: (int)playerCardsToTrade : (int)monsterCardsToTrade;

#pragma mark Game Flow Control Structures

- (void) playTheGameWithHero:(Hero*)Hero andMonster:(Monster*)Monster;

@property (nonatomic) state gameState;

@end
