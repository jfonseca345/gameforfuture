//
//  CardCombatController.m
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 16/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "CardCombatController.h"
#import "CardContainer.h"

@implementation CardCombatController

- (id)init
{
    self = [super init];
    
    self.deck = [NSMutableArray array];
    
    for (int n = 0; n < numberCount; n++) {
        for (int s = 0; s < suitCount; s++) {
            CardContainer *card = [[CardContainer alloc] init];
            card.number = (gameDeckNumber) n;
            card.suit = (gameDeckSuit) s;
            
            [self.deck addObject:card];
        }
    }
    return self;
}

-(void) shuffleCards{
    NSLog(@"InitialConfiguration:");
    for(int i = 0; i < [self.deck count]; i++){
        NSLog([NSString stringWithFormat:@"%@",[self.deck[i] description]]);
    }
    
    for(int i = 0; i < [self.deck count]; i++){
        int j = arc4random_uniform((u_int32_t) self.deck.count);
        
        NSObject* auxiliarSwap = self.deck[i];
        self.deck[i] = self.deck[j];
        self.deck[j] = auxiliarSwap;
        
    }
    
    NSLog(@"shuffledConfigurtion:");
    for(int i = 0; i < [self.deck count]; i++){
        NSLog([NSString stringWithFormat:@"%@",[self.deck[i] description]]);
    }
}

@end
