//
//  CardCombatController.h
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 16/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deck.h"
#import "CardContainer.h"

@interface CardCombatController : NSObject

#pragma Deck Manipulation Methods and Atributes

@property (strong, nonatomic) NSMutableArray* deck;
@property int drawCounter;

-(CardContainer*) drawCard;
-(void) shuffleCards;

#pragma Hand Atributes
@property (strong, nonatomic) NSMutableArray* playerHand;
@property (strong, nonatomic) NSMutableArray* monsterHand;

#pragma Game Managements Methods and Atributes

@property int pot;

-(void) prepareGame;
-(void) tradeCards: (int)playerCardsToTrade : (int)monsterCardsToTrade;

@end
