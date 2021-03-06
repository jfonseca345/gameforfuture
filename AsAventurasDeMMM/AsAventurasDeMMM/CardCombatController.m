//
//  CardCombatController.m
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 16/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "CardCombatController.h"
#import "CombateScene.h"
#import "AbstractState.h"
#import "PreCombatState.h"

@interface CardCombatController()

@property moveStruct moveOne;
@property moveStruct moveTwo;
@property int firstPlayer;
@property int roundCounter;

@property int currentBet;

@property AbstractState * stateMachine;

@property id<IsAPlayerProtocol> p1; //Devem sem atribuidos randomicamente
@property id<IsAPlayerProtocol> p2;

@end

@implementation CardCombatController

- (id)initWithHero: (Hero *)myHero andMonster:(Monster *)myMonster
{
    self = [super init];
    
//    self.drawCounter = 1;
//    self.deck = [NSMutableArray array];
    self.gameDeck = [[GameDeck alloc] init];
    
    self.player = myHero;
    self.monster = myMonster;
    
    self.P1Hand = [self.gameDeck DistributetoHand];
    self.P2Hand = [self.gameDeck DistributetoHand];
    
    self.gameState = PRE_COMBAT;
    
    self.stateMachine = [[PreCombatState alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateChange) name:@"stateChange" object:nil];//Passagem de notificacao para chamada do proximo estado
    
    [self.stateMachine runStateWith:self.p1 and:self.p2 onGame:self];
    
    return self;
}

-(void) stateChange
{
    if (self.gameState != COMBAT_END) //Enquanto nao acabar...
    {
        [self.stateMachine runStateWith:self.p1 and:self.p2 onGame:self];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"endCombat" object:nil];//Avisa scene que acabou
    }
}

#pragma mark Game Managements Methods

//Prepares the game, 
-(void) prepareGame;
{
    [self prepareRound];
    self.P1Hand = [self.gameDeck DistributetoHand];
    self.P2Hand = [self.gameDeck DistributetoHand];
    
}

//Prepares the round
-(void) prepareRound
{
    //Sets the pot to zero
    self.pot = 0;
    
    //Sets the current bet to 1
    self.currentBet = 1;
    
    //Shuffles the deck
    [self.gameDeck restartAndShuffle];
//    [self shuffleCards];
    
    //Init both move strings
    self.playerMove = NULL;
    self.monsterMove = NULL;
    
//    [self.playerHand removeAllObjects];
//    [self.monsterHand removeAllObjects];
    
    //Deals both hands
    for(int i=0; i<5; i++)
    {
        //Deals a card to the player
//        CardContainer *card = [self drawCard];
//        [self.playerHand addObject:card];
        
        //Deals a card to the monster
//        card = [self drawCard];
//        [self.monsterHand addObject:card];
    }
    
}

//Trade cards from both hands, the argument has the indexes of the cards to be traded
-(void) tradeCardsP1: (int)player1CardsToTrade P2:(int) player2CardsToTrade
{
    
    int tradeMask = 0b00001;
    
    //We start by trading the players cards
    for(int i=0 ;i<5;i++)
    {
        if(player1CardsToTrade && tradeMask)
        {
            //We can trade that index
            [self.P1Hand.handCards removeObjectAtIndex:i];
            [self.P1Hand.handCards addObject:[self.gameDeck DrawCard]];
        }
        //Shift the player mask
        player1CardsToTrade = player1CardsToTrade >> 1;
    }
    
    for(int i=0; i<5; i++)
    {
        if(player2CardsToTrade && tradeMask)
        {
            //We can trade that index
            [self.P2Hand.handCards removeObjectAtIndex:i];
            [self.P2Hand.handCards addObject:[self.gameDeck DrawCard]];
        }
        //Shift the monster mask
        player2CardsToTrade = player2CardsToTrade >> 1;
    }
}

#pragma mark Deck Manipulation Methods
//Shuffles the deck
//-(void) shuffleCards{
//    //NSLog(@"InitialConfiguration:");
//    for(int i = 0; i < [self.deck count]; i++){
////        NSLog([NSString stringWithFormat:@"%@",[self.deck[i] description]]);
//    }
//    
//    for(int i = 0; i < [self.deck count]; i++){
//        int j = arc4random_uniform((u_int32_t) self.deck.count);
//        
//        NSObject* auxiliarSwap = self.deck[i];
//        self.deck[i] = self.deck[j];
//        self.deck[j] = auxiliarSwap;
//        
//    }
//    
//   // NSLog(@"shuffledConfiguration:");
//    for(int i = 0; i < [self.deck count]; i++){
////        NSLog([NSString stringWithFormat:@"%@",[self.deck[i] description]]);
//    }
//    
//    //Resets the drawCounter
//    self.drawCounter = 1;
//}


//Draws a card from the deck
//-(CardContainer*) drawCard{
//    
//    //If the deck is empty
//    if(self.drawCounter == self.deck.count-1)
//    {
//        NSLog(@"\nErro, deck vazio");
//        return NULL;
//    }
//    
//    //Picks the last card and changes the drawCounter, making the last card inaccessible from the deck
//    CardContainer *card = [self.deck objectAtIndex: (self.deck.count-self.drawCounter)];
//    self.drawCounter++;
//    
//    return card;
//    
//}



//Evaluate hand
-(float) evaluateHand: (NSMutableArray*) hand : (NSString*) move
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
    hand = [[hand sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        CardContainer *card1 = (CardContainer*) obj1;
        CardContainer *card2 = (CardContainer*) obj2;
        
        if(card1.number == card2.number)
            return (NSComparisonResult)NSOrderedSame;
       
        if(card2.number > card1.number)
            return (NSComparisonResult)NSOrderedAscending;
        
        else
            return (NSComparisonResult)NSOrderedDescending;
    }] mutableCopy];
    
    for(int i=0;i<5;i++)
    {
        CardContainer *card = [hand objectAtIndex:i];
        printf("%ld ",(long)card.number);
    }
    printf("\n");
    
    //Assuming it is sorted, we will detect if there is a Straight
    
    for(int i=0; i<4; i++)
    {
        CardContainer *card1 = [hand objectAtIndex:i];
        CardContainer *card2 = [hand objectAtIndex:i+1];
        
        if(!((card1.number+1)%7) == (card2.number%7))
            break;
        
        //If i == 4, it means that the loop never broke, so we have a straight
        if(i==4)
        {
            //Let us just check if we have a plain flush or a straight flush
            for(int j=0; j<4; j++)
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
        for(int i =0; i<4; i++)
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
                
                for(int j=0; j<4; j++)
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
                    move = @"High Card";
                    return 1.0 +((float)(highCard.number)/10.0);
                break;
        }
    }
    return 0;
}

- (void) setupGameBegin
{
    //<gohorse>
    moveStruct a;
    a.action = NONE;
    
    self.moveOne = a;
    self.moveTwo = a;
    //</gohorse>
    
    self.firstPlayer = arc4random_uniform(1);
    self.roundCounter = 0;
}

//Evaluate both hands, then damages the loser
-(void) showDown: (NSMutableArray*)playerHand : (NSMutableArray*) monsterHand
{
    //We evaluate both hands
    float playerScore = [self evaluateHand: playerHand: self.playerMove ];
    
    float monsterScore = [self evaluateHand:monsterHand: self.monsterMove];
    
    NSLog(@"SHOWDOWN RESULTS: Player: %f Monster: %f",playerScore,monsterScore);
    
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

-(void)aButtonTapped
{
    [self.player setMove:CHECK];
}
-(void)bButtonTapped
{
//    [self removeFromParent];
    [self.player setMove:FOLD];
}
-(void)cButtonTapped
{
    [self.player setMove:RAISE];
}

@end
