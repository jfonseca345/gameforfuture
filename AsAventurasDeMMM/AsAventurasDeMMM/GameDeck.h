//
//  GameDeck.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "deck.h"
#import "Hand.h"
#import "Card.h"

@interface GameDeck : NSObject

- (void) Shuffle;

- (void) DistributetoHand1: (Hand *)hand1 andHand2:(Hand *)hand2;

- (Card *) DrawCard;

@end
