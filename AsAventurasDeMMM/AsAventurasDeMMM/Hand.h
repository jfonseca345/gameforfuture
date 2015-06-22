//
//  Hand.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Card.h"

@interface Hand : SKNode

@property NSMutableArray * handCards;

- (void) flipCards;
- (instancetype)initWithArray:(NSArray *)handArray;
- (int)selectedCardsBitMask;
@end
