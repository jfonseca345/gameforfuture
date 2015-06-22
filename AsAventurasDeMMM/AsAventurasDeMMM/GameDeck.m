//
//  GameDeck.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "GameDeck.h"

@interface GameDeck()

@property NSMutableArray * deckArray;


@end

@implementation GameDeck

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        for (int n = 0; n < numberCount; n++) {
            for (int s = 0; s < suitCount; s++) {
                CardContainer *card = [[CardContainer alloc] init];
                card.number = (gameDeckNumber) n;
                card.suit = (gameDeckSuit) s;
                
                [self.deckArray addObject:card];
            }
        }
    }
    
    return self;
}

- (void) Shuffle
{
    for(int i = 0; i < [self.deckArray count]; i++){
        int j = arc4random_uniform((u_int32_t) self.deckArray.count);
        
        NSObject* auxiliarSwap = self.deckArray[i];
        self.deckArray[i] = self.deckArray[j];
        self.deckArray[j] = auxiliarSwap;
        
    }
}

- (void) DistributetoHand1: (Hand*)hand1 andHand2:(Hand *)hand2
{
    NSMutableArray * tempHand1 = [NSMutableArray alloc];
    NSMutableArray * tempHand2 = [NSMutableArray alloc];
    for(int i=0; i<5; i++)
    {
        //Deals a card to the player
        CardContainer *card = [self DrawCard];
        [tempHand1 addObject:card];
        
        //Deals a card to the monster
        card = [self DrawCard];
        [tempHand2 addObject:card];
    }
    hand1 = [[Hand alloc] initWithArray:tempHand1];
    hand2 = [[Hand alloc] initWithArray:tempHand2];
}

- (CardContainer *) DrawCard;
{
    if(self.deckArray.count == 0)
    {
        NSLog(@"\nErro, deck vazio");
        return NULL;
    }
    
    //Picks the last card, removes ans returns it
    CardContainer *card = [self.deckArray lastObject];
    [self.deckArray removeLastObject];
    
    return card;
}

- (void) restartAndShuffle
{
    [self.deckArray removeAllObjects];
    for (int n = 0; n < numberCount; n++) {
        for (int s = 0; s < suitCount; s++) {
            CardContainer *card = [[CardContainer alloc] init];
            card.number = (gameDeckNumber) n;
            card.suit = (gameDeckSuit) s;
            
            [self.deckArray addObject:card];
        }
    }
    [self Shuffle];
}

@end
