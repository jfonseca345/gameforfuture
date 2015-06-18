//
//  CardSpriteFactory.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/18/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "CardSpriteFactory.h"

@implementation CardSpriteFactory

+ (SKSpriteNode *)CardNodeWithNumber:(gameDeckNumber)number andSuit:(gameDeckSuit)suit
{
    SKSpriteNode * card;
    switch (number) {
        case TWO:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"2Ouros"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"2Espadas"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"2Copas"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"2Paus"];
                    break;
                default:
                    break;
            }
            break;
        case THREE:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"3Ouros"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"3Espadas"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"3Copas"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"3Paus"];
                    break;
                default:
                    break;
            }
            break;
        case FOUR:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"4Ouros"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"4Espadas"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"4Copas"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"4Paus"];
                    break;
                default:
                    break;
            }
            break;
        case FIVE:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"5Ouros"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"5Espadas"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"5Copas"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"5Paus"];
                    break;
                default:
                    break;
            }
            break;
        case SIX:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"6Ouros"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"6Espadas"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"6Copas"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"6Paus"];
                    break;
                default:
                    break;
            }
            break;
        case SEVEN:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"7Ouros"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"7Espadas"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"7Copas"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"7Paus"];
                    break;
                default:
                    break;
            }
            break;
        case ACE:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"As-Ouros"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"As-Espadas"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"As-Copas"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"As-Paus"];
                    break;
                default:
                    break;
            }
            break;
        default:
            NSLog(@"ERROR CARD SPRITE FACTORY");
            break;
    }
    return card;
}

@end
