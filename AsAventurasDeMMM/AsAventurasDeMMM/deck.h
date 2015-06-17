//
//  deck.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/16/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#ifndef AsAventurasDeMMM_deck_h
#define AsAventurasDeMMM_deck_h

typedef NS_ENUM(NSInteger, gameDeckNumber)
{//A,7,6,5,4,3,2.
    A = 0,
    SEVEN,
    SIX,
    FIVE,
    FOUR,
    THREE,
    TWO,
    
    numberCount
};

typedef NS_ENUM(NSInteger, gameDeckSuit)
{//Diamonds, Spades, Hearts, Clubs
    DIAMOND = 0,
    SPADE,
    HEART,
    CLUB,
    
    suitCount
    
};

#endif
