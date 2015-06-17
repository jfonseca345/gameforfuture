//
//  CardCombatController.m
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 16/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "CardCombatController.h"

@implementation CardCombatController

- (id)init
{
    self = [super init];
    
    self.drawCounter = 1;
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

#pragma Game Managements Methods

//Prepares the game, 
-(void) prepareGame
{
    self.pot = 0;
}


#pragma Deck Manipulation Methods

//Draws a card from the deck
-(CardContainer*) drawCard{
    
    //If the deck is empty
    if(self.drawCounter == self.deck.count-1)
    {
        NSLog(@"\nErro, deck vazio");
        return NULL;
    }
    
    //Picks the last card and changes the drawCounter, making the last card inaccessible from the deck
    CardContainer *card = [self.deck objectAtIndex: (self.deck.count-self.drawCounter)];
    self.drawCounter++;
    
    return card;
    
}

//Shuffles the deck
-(void) shuffleCards{
    NSLog(@"InitialConfigurtion:");
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
    
    //Resets the drawCounter
    self.drawCounter = 1;
}

@end
