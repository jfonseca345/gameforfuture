//
//  CardContainer.m
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 16/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "CardContainer.h"

@implementation CardContainer


- (NSString *)description
{
    NSArray* numberArray = @[@"A",@"K",@"Q",@"J",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2"];
    NSArray* suitArray = @[@"DIAMOND",@"SPADE",@"HEART",@"CLUB"];
    return [NSString stringWithFormat:@"Card: < %@, %@ >",numberArray[(int)self.number], suitArray[(int)self.suit] ];
}
@end
