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
- (Hand*) DistributetoHand;
- (CardContainer *) DrawCard;
- (void) restartAndShuffle;

@end
