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
    
    self.playerHand = [NSMutableArray array];
    self.monsterHand = [NSMutableArray array];
    
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

#pragma mark Game Managements Methods

//Prepares the game, 
-(void) prepareGame: (Hero*)Hero : (Monster*)Monster;
{
    [self prepareRound];
    
    //Setup both Monster and Player
    self.player = Hero;
    self.monster = Monster;
}

//Prepares the round
-(void) prepareRound
{
    //Sets the pot to zero
    self.pot = 0;
    
    //Shuffles the deck
    [self shuffleCards];
    
    //Deals both hands
    for(int i=0; i<5; i++)
    {
        //Deals a card to the player
        CardContainer *card = [self drawCard];
        [self.playerHand addObject:card];
        
        //Deals a card to the monster
        card = [self drawCard];
        [self.monsterHand addObject:card];
    }
    
}

//Trade cards from both hands, the argument has the indexes of the cards to be traded
-(void) tradeCards: (int)playerCardsToTrade : (int) monsterCardsToTrade
{
    int tradeMask = 0x00001;
    
    //We start by trading the players cards
    for(int i=0 ;i<5;i++)
    {
        if(playerCardsToTrade && tradeMask)
        {
            //We can trade that index
            [self.playerHand removeObjectAtIndex:i];
            [self.playerHand addObject:[self drawCard]];
        }
        //Shift the player mask
        playerCardsToTrade = playerCardsToTrade >> 1;
    }
    
    for(int i=0; i<5; i++)
    {
        if(monsterCardsToTrade && tradeMask)
        {
            //We can trade that index
            [self.monsterHand removeObjectAtIndex:i];
            [self.monsterHand addObject:[self drawCard]];
        }
        //Shift the monster mask
        monsterCardsToTrade = monsterCardsToTrade >> 1;
    }
}

#pragma mark Deck Manipulation Methods

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

//Evaluate hand
-(float) evaluateHand: (NSMutableArray*) hand
{
    /*
     1.0 High Card -> Nenhuma combinação, apenas uma carta. A carta mais alta do jogo é o A.
     2.0 One Pair  -> Um par de cartas iguais
     3.0 Two Pair  -> Dois pares de cartas iguais
     4.0 Three of a kind -> Uma trinca de cartas iguais
     5.0 Straight -> 5 cartas seguidas de naipes diferentes. Ex: 3,4,5,6,7.
     6.0 Flush   -> 5 cartas do mesmo naipe, não seguidas
     7.0 Full House -> Uma trinca e um par
     8.0 Four of a kind -> 4 cartas iguais
     9.0 Straight Flush -> Uma sequencia de mesmo naipe
    */
    
    //First of all, we must sort our hand to make it easier to detect straights
    [hand sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        CardContainer *card1 = obj1;
        CardContainer *card2 = obj2;
        
        if(card1.number == card2.number)
            return (NSComparisonResult)NSOrderedSame;
        
        if(card2.number > card1.number)
            return (NSComparisonResult)NSOrderedAscending;
        
        else
            return (NSComparisonResult)NSOrderedDescending;
    }];
    
    //Assuming it is sorted, we will detect if there is a Straight
    
    for(int i=0; i<4; i++)
    {
        CardContainer *card1 = [hand objectAtIndex:i];
        CardContainer *card2 = [hand objectAtIndex:i+1];
        
        if(!((card1.number+1)%7) == (card2.number%7))
            break;
        
        //If i == 3, it means that the loop never broke, so we have a straight
        if(i==3)
        {
            //Let us just check if we have a plain flush or a straight flush
            for(int j=0; j<4; j++)
            {
                CardContainer *cardFoo = [hand objectAtIndex:j];
                CardContainer *cardBar = [hand objectAtIndex:j+1];
                
                if(!(cardFoo.suit == cardBar.suit))
                    break;
                
                //If j ==3, it also means that the loop never broke, so we have a straight flush
                if(j==3)
                {
                    return 9.0;
                }
            }
            //If we broke from the previous loop, we have a plain straight
            return 5.0;
        }
        //We do not have a straight, let us check other combinations
        
        
        
    }
    
    
    
    return 0;
}

- (void) playTheGameWithHero:(Hero*)Hero andMonster:(Monster*)Monster;
{
    self.gameState = PRE_COMBAT;
    [self prepareGame:Hero :Monster];
    self.gameState = PRE_ROUND;
    [self prepareRound];
    
    
}

//Shuffles the deck
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
    
    //Resets the drawCounter
    self.drawCounter = 1;
}

@end
