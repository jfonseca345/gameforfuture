//
//  IsAPlayerProtocol.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/18/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#ifndef AsAventurasDeMMM_IsAPlayerProtocol_h
#define AsAventurasDeMMM_IsAPlayerProtocol_h

#import "deck.h"
#import "CombatState.h"

typedef struct myMove { //Struct that holds all information about a move
    action action;
    int raiseNewValue;
} moveStruct;

@protocol IsAPlayerProtocol

- (int) cardsToTrade;

- (moveStruct) move;

@end

#endif
