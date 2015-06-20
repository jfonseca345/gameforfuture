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
#import "IsAPlayerProtocol.h"
#import "AsAventurasDeMMM-Swift.h"
#import "CombateScene.h"
#import "Hand.h"
#import "GameDeck.h"

@interface CardCombatController : NSObject <pokerButtonPadDelegate>

- (id)initWithHero: (Hero *)myHero andMonster:(Monster *)myMonster;

#pragma mark Players Attributes

@property (nonatomic) Hero* player;
@property (nonatomic) NSString* playerMove;

@property (nonatomic) Monster* monster;
@property (nonatomic) NSString* monsterMove;


#pragma mark Deck Manipulation Methods and Attributes


@property GameDeck * gameDeck;
@property (strong, nonatomic) NSMutableArray* deck;//Remover quando arrumar deck
@property int drawCounter;

-(CardContainer*) drawCard;//Deve ser implementado no deck
-(void) shuffleCards;//Deve ser implementado no deck

#pragma mark Hand Atributes
@property Hand * P1Hand;
@property Hand * P2Hand;

@property (strong, nonatomic) NSMutableArray* playerHand;//Remover posteriormente, quando arrumar hand
@property (strong, nonatomic) NSMutableArray* monsterHand;

#pragma mark Game Managements Methods and Attributes

@property int pot;

-(void) prepareGame: (Hero*)withHero : (Monster*)andMonster;
-(void) prepareRound;
-(void) tradeCards: (int)playerCardsToTrade : (int)monsterCardsToTrade;
-(void) showDown: (NSMutableArray*)playerHand : (NSMutableArray*) monsterHand;


@property (nonatomic) state gameState;

@end
