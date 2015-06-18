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

@interface CardCombatController : NSObject

#pragma mark Players Attributes

@property (nonatomic) Hero* player;
@property (nonatomic) NSString* playerMove;

@property (nonatomic) Monster* monster;
@property (nonatomic) NSString* monsterMove;


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
-(void) showDown: (NSMutableArray*)playerHand : (NSMutableArray*) monsterHand;

#pragma mark Game Flow Control Structures

- (void) playTheGameWithHero:(Hero<IsAPlayerProtocol>*)Hero andMonster:(Monster<IsAPlayerProtocol>*)Monster;

@property (nonatomic) state gameState;

@end
