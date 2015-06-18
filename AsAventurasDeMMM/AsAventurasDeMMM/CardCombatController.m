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
    
    int tradeMask = 0b00001;
    
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
     ->2.0 One Pair  -> Um par de cartas iguais
     ->3.0 Two Pair  -> Dois pares de cartas iguais
     ->4.0 Three of a kind -> Uma trinca de cartas iguais
     ->5.0 Straight -> 5 cartas seguidas de naipes diferentes. Ex: 3,4,5,6,7.
     6.0 Flush   -> 5 cartas do mesmo naipe, não seguidas
     ->7.0 Full House -> Uma trinca e um par
     ->8.0 Four of a kind -> 4 cartas iguais
     ->9.0 Straight Flush -> Uma sequencia de mesmo naipe
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
    
    for(int i=0; i<5; i++)
    {
        CardContainer *card1 = [hand objectAtIndex:i];
        CardContainer *card2 = [hand objectAtIndex:i+1];
        
        if(!((card1.number+1)%7) == (card2.number%7))
            break;
        
        //If i == 4, it means that the loop never broke, so we have a straight
        if(i==4)
        {
            //Let us just check if we have a plain flush or a straight flush
            for(int j=0; j<5; j++)
            {
                CardContainer *cardFoo = [hand objectAtIndex:j];
                CardContainer *cardBar = [hand objectAtIndex:j+1];
                
                if(!(cardFoo.suit == cardBar.suit))
                    break;
                
                //If j == 4, it also means that the loop never broke, so we have a straight flush
                if(j== 4)
                {
                    return 9.0;
                }
            }
            //If we broke from the previous loop, we have a plain straight
            return 5.0;
        }
        //We do not have a straight, let us check other combinations
        
        //Let us count how many groups of different cards we have
        int firstGroupNumber = 0;
        int secondGroupNumber = 0;
        
        //Boolean to help us define which group we are counting
        BOOL group = false;
        
        //Since the hand is sorted, it is easy to count the number of combinations
        for(int i =0; i<5; i++)
        {
            CardContainer *card1 = [hand objectAtIndex:i];
            CardContainer *card2 = [hand objectAtIndex:i+1];
            
            if(card1.number != card2.number)
            {
                //If we already counted a group
                if(firstGroupNumber > 0)
                    //We can start counting a second group
                    group = true;
                
            }else
            {
                //We check which group we are counting
                if(group){
                    if(secondGroupNumber == 0)
                        secondGroupNumber = 2;
                    else
                    secondGroupNumber++;
                }
                else
                    if(firstGroupNumber == 0)
                        firstGroupNumber = 2;
                else
                    firstGroupNumber++;
            }
            
        }
        
        //Now we counted how many groups, and how many card on each group
        
        switch (firstGroupNumber+secondGroupNumber) {
            case 2:
            //We have one pair
                return 2.0;
                break;
            case 3:
            //We have a Three of a kind
                return 4.0;
                break;
            case 4:
            //We need to check if we have two pair or four of a kind
            if(firstGroupNumber == secondGroupNumber)
                //We have two pair
                return 3.0;
            else
                //We have a four of a kind
                return 8.0;
                break;
            case 5:
                //We have a full house
                return 7.0;
                break;

            default:
                //We dont have any combinations, lastly let us see if we at least have a flush
                
                for(int j=0; j<5; j++)
                {
                    CardContainer *cardFoo = [hand objectAtIndex:j];
                    CardContainer *cardBar = [hand objectAtIndex:j+1];
                    
                    if(!(cardFoo.suit == cardBar.suit))
                        break;
                    
                    //If j == 4, it also means that the loop never broke, so we have a flush
                    if(j== 4)
                    {
                        return 6.0;
                    }
                }
                    //If we got to this point we have only a high card
                    CardContainer *highCard = [hand lastObject];
                    
                    return 1.0 +((float)(highCard.number)/10.0);
                break;
        }
    }
    return 0;
}

- (void) playTheGameWithHero:(Hero<IsAPlayerProtocol>*)Hero andMonster:(Monster<IsAPlayerProtocol>*)Monster;
{
    int firstPlayer = arc4random_uniform(1), i;
    move moveOne, moveTwo;
    self.gameState = PRE_COMBAT;
    
    while (self.gameState != COMBAT_END) {
        switch (self.gameState) {
            case PRE_COMBAT:
                [self prepareGame:Hero :Monster];
                self.gameState = PRE_ROUND;
                break;
            case PRE_ROUND:
                [self prepareRound];
                self.gameState = FIRST_BETTING;
                break;
            case FIRST_BETTING:
                if (firstPlayer == 0){
                    moveOne = [Hero move];
                }
                else{
                    moveOne = [Monster move];
                }
                if (moveOne.action == FOLD){
                    self.gameState = DAMAGE;
                }
                else{
                    self.gameState = TRADE_CARDS;
                }
                break;
            case TRADE_CARDS:
                [self tradeCards:[Hero cardsToTrade] :[Monster cardsToTrade]];
                self.gameState = SECOND_BETTING;
                break;
            case SECOND_BETTING:
                if (firstPlayer == 0){
                    moveTwo = [Monster move];
                }
                else{
                    moveTwo = [Hero move];
                }
                if (moveTwo.action == FOLD){
                    self.gameState = DAMAGE;
                }
                else
                {
                    self.gameState = SHOWDOWN;
                }
                break;
            case SHOWDOWN:
                break;
            case DAMAGE:
                break;
            default:
                NSLog(@"ERROR, UNKNOWN STATE");
                break;
        }
    }
    
}

//Returns the damage done based on the pot
-(int) damageDone : (int)attack : (int)defense{
        int dam = self.pot*(attack-defense);
        if(dam < 0)
            dam = 1;
    
    return dam;
    
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
