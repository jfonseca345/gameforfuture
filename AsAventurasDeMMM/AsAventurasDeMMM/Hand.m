//
//  Hand.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "Hand.h"

@implementation Hand

- (void) flipCards
{
    int i;
    for (i = 0; i < [self.handCards count]; i++)
    {
        [((Card *)[self.handCards objectAtIndex:i]) flipCard];
    }
}

- (instancetype)initWithArray:(NSArray *)handArray
{
    self = [super init];
    
    if (self){
        int i;
        long newSize = [self.handCards count];
        long cardPosition = (newSize * 128/4);
        for (i = 0; i < newSize; i++)
        {
            Card * newCard = [[Card alloc] initWithCardContainer:[handArray objectAtIndex:i]];
            [self.handCards addObject:newCard];
            [newCard setPosition:CGPointMake(newCard.position.x, cardPosition)];
            [self addChild: newCard];
            cardPosition -= 128/2;
        }
    }
    
    return self;
}

- (int)selectedCardsBitMask
{
    int i;
    int cardsBitMask = 0;
    for (i = 0; i < [self.handCards count]; i++)
    {
        cardsBitMask |= (([(Card *)[self.handCards objectAtIndex:i] selected]) << i);
    }
    return cardsBitMask;
}

@end
