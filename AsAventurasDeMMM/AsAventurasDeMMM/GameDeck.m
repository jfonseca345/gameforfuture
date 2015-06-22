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
    self.deckArray = [NSMutableArray array];
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
        [self Shuffle];
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

- (Hand*) DistributetoHand
{
    NSMutableArray * tempHand1 = [NSMutableArray array];
    for(int i=0; i<5; i++)
    {
        //Deals a card
        CardContainer *card = [self DrawCard];
        [tempHand1 addObject:card];
    }
    Hand* hand = [[Hand alloc] initWithArray:tempHand1];
    return hand;
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
