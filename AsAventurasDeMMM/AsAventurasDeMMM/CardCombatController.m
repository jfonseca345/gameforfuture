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
    
    //Init both move strings
    self.playerMove = NULL;
    self.monsterMove = NULL;
    
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
-(float) evaluateHand: (NSMutableArray*) hand : (NSString*) move
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
                    move = @"Straight Flush";
                    return 9.0;
                }
            }
            //If we broke from the previous loop, we have a plain straight
            move = @"Straight";
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
                move = @"One Pair";
                return 2.0;
                break;
            case 3:
            //We have a Three of a kind
                move = @"Three of a Kind";
                return 4.0;
                break;
            case 4:
            //We need to check if we have two pair or four of a kind
            if(firstGroupNumber == secondGroupNumber)
            {    //We have two pair
                move = @"Two Pair";
                return 3.0;
            }
            else
                //We have a four of a kind
                move = @"Four of a Kind";
                return 8.0;
                break;
            case 5:
                //We have a full house
                move = @"Full House";
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
                    move = @"HIGH CARD";
                    return 1.0 +((float)(highCard.number)/10.0);
                break;
        }
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

//Evaluate both hands, then damages the loser
-(void) showDown: (NSMutableArray*)playerHand : (NSMutableArray*) monsterHand
{
    //We evaluate both hands
    float playerScore = [self evaluateHand: playerHand: self.playerMove ];
    
    float monsterScore = [self evaluateHand:monsterHand: self.monsterMove];
    
    if(playerScore > monsterScore)
    {
      //Player Wins
        int damage = [self damageDone:(int)self.player.atk :(int)self.monster.Def];
        self.monster.HP -= damage;
        
    }else
    if(playerScore < monsterScore)
    {
     //Monster Wins
        int damage = [self damageDone:(int)self.monster.Atk :(int)self.player.def];
        self.player.hp -=damage;
    }
    else
    {
        //Tie
        //Pot is divided by 2
        self.pot = self.pot/2;
        //Calculate damage based on new pot
        int monsterDamage = [self damageDone:(int) self.player.atk :(int) self.monster.Def];
        int playerDamage = [self damageDone:(int) self.monster.Atk :(int) self.player.def];
        
        self.monster.HP -=monsterDamage;
        self.player.hp -= playerDamage;
        
    }
    
}


//Returns the damage done based on the pot
-(int) damageDone : (int)attack : (int)defense{
        int dam = self.pot*(attack-defense);
        if(dam < 0)
            dam = 1;
    
    return dam;
    
}

@end
