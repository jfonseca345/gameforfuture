//
//  CardSpriteFactory.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/18/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "deck.h"

@interface CardSpriteFactory : NSObject

+ (SKSpriteNode *)CardNodeWithNumber:(gameDeckNumber)number andSuit:(gameDeckSuit)suit;

@end
