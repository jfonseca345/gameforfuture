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
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"2Diamond"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"2Spade"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"2Heart"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"2Club"];
                    break;
                default:
                    break;
            }
            break;
        case THREE:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"3Diamond"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"3Spade"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"3Heart"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"3Club"];
                    break;
                default:
                    break;
            }
            break;
        case FOUR:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"4Diamond"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"4Spade"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"4Heart"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"4Club"];
                    break;
                default:
                    break;
            }
            break;
        case FIVE:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"5Diamond"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"5Spade"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"5Heart"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"5Club"];
                    break;
                default:
                    break;
            }
            break;
        case SIX:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"6Diamond"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"6Spade"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"6Heart"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"6Club"];
                    break;
                default:
                    break;
            }
            break;
        case SEVEN:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"7Diamond"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"7Spade"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"7Heart"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"7Club"];
                    break;
                default:
                    break;
            }
            break;
        case ACE:
            switch (suit) {
                case DIAMOND:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"aceDiamond"];
                    break;
                case SPADE:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"aceSpade"];
                    break;
                case HEART:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"aceHeart"];
                    break;
                case CLUB:
                    card = [[SKSpriteNode alloc] initWithImageNamed:@"aceClub"];
                    break;
                default:
                    break;
            }
            break;
        default:
            card = [[SKSpriteNode alloc] initWithImageNamed:@"card_cover"];
            break;
    }
    return card;
}

@end
