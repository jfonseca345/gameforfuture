//
//  CombatState.h
//  AsAventurasDeMMM
//
//  Created by Henrique de Abreu Amitay on 17/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#ifndef AsAventurasDeMMM_CombatState_h
#define AsAventurasDeMMM_CombatState_h

typedef NS_ENUM(NSInteger, state)
{/*PRE_COMBAT,PRE_ROUND,FIRST_BETTING, TRADE_CARDS, SECOND_BETTING, SHOWDOWN,
    DAMAGE,COMBAT_END*/
    PRE_COMBAT, //Before combat begins, set the game
    PRE_ROUND,  //Shuffles the deck, deals the hands, pot = zero
    FIRST_BETTING, //Defines the first player to play, he bets. Second player then bets (check, fold, raise)
    TRADE_CARDS,  //Players trade cards
    SECOND_BETTING, //Second betting, first player bets (check,fold,raise), second players bets (check,fold,raise)
    SHOWDOWN,   //Compare hands
    DAMAGE,     //Deals damage to loser
    COMBAT_END  //Check if someone's hp is zero, if so ends.
    
};

typedef NS_ENUM(NSInteger, action)
{/**/
    CHECK, //Bets the same
    RAISE, //Raises...
    FOLD, //Gives up
    
};

#endif
