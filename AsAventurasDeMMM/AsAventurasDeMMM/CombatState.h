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
    PRE_COMBAT,
    PRE_ROUND,
    FIRST_BETTING,
    TRADE_CARDS,
    SECOND_BETTING,
    SHOWDOWN,
    DAMAGE,
    COMBAT_END
    
};

typedef NS_ENUM(NSInteger, action)
{/**/
    CHECK, //Bets the same
    RAISE, //Raises...
    FOLD, //Gives up
    
};

#endif
