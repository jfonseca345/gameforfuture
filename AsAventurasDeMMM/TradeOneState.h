//
//  TradeOneState.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "AbstractState.h"

@interface TradeOneState : AbstractState
- (void)runStateWith:(id<IsAPlayerProtocol>)Player1 and:(id<IsAPlayerProtocol>)Player2 onGame:(CardCombatController *)Controller;
@end
