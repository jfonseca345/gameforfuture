//
//  Card.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "CardContainer.h"
#import "CardSpriteFactory.h"

typedef NS_ENUM(NSInteger, SideUp)
{//A,7,6,5,4,3,2.
    UP,
    DOWN,
};

@interface Card : SKNode //Informacoes sobre a carta e o sprite

- (instancetype)initWithCardContainer:(CardContainer *)container;
- (void)flipCard;

@property bool selectable;
@property bool selected;

@end
