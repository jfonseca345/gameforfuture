//
//  Card.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "Card.h"


@interface Card()

@property SideUp cardSide;

@property SKSpriteNode * cardUp;
@property SKSpriteNode * cardDown;

@end

@implementation Card

- (instancetype)initWithCardContainer:(CardContainer *)container
{
    self = [super init];
    
    if (self)
    {
        self.cardSide = DOWN;
        self.selectable = false;
        self.cardUp = [CardSpriteFactory CardNodeWithNumber:[container number] andSuit:[container suit]];
        [self.cardUp setColor:[UIColor redColor]];//Cor para quando
        self.cardDown = [SKSpriteNode spriteNodeWithImageNamed:@"card_cover"];
        
        [self addChild:self.cardUp];
        [self addChild:self.cardDown];
        
        [self.cardDown setHidden:YES];
        
        [self setUserInteractionEnabled:YES];
    }
    
    return self;
}

- (void)flipCard
{
    if (self.cardSide == UP)
    {
        self.cardSide = DOWN;
        [self.cardUp setHidden:YES];
        [self.cardDown setHidden:NO];
    }
    else
    {
        self.cardSide = UP;
        [self.cardDown setHidden:YES];
        [self.cardUp setHidden:NO];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1)
    {
        CGPoint pointHere = [[touches anyObject] locationInNode:self];
        if ([[self nodeAtPoint:pointHere] isEqual:self])
        {
            [self toggleCardSelected];
        }
    }
}

- (void) toggleCardSelected
{
    if (self.cardSide == UP && self.selectable) //Ele so pode selecionar se ja estiver para cima
    {
        if (self.selected)
        {
            self.selected = NO;
            [self.cardUp setColorBlendFactor:0];
        }
        else
        {
            self.selected = YES;
            [self.cardUp setColorBlendFactor:0.5];
        }
    }
}

@end
