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
{//A,K,Q,J,10,9,8,7,6,5,4,3,2.
    A = 0,
    K,
    Q,
    J,
    TEN,
    NINE,
    EIGHT,
    SEVEN,
    SIX,
    FIVE,
    FOUR,
    THREE,
    TWO,
    
    numberCount
};

typedef NS_ENUM(NSInteger, gameDeckSuit)
{//Diamonds, Swords, Hearts, Clubs
    DIAMOND = 0,
    SWORD,
    HEART,
    CLUB,
    
    suitCount
    
};

#endif
