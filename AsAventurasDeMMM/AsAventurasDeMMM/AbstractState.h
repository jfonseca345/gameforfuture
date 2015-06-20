//
//  AbstractState.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IsAPlayerProtocol.h"
#include "CardCombatController.h"


@interface AbstractState : NSObject

- (void)runStateWith:(id<IsAPlayerProtocol>)Player1 and:(id<IsAPlayerProtocol>)Player2 onGame:(CardCombatController *)Controller;

@end
