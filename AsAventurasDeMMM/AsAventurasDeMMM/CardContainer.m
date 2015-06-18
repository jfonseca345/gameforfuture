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
    NSArray* numberArray = @[@"2", @"3",@"4",@"5",@"6",@"7",@"A"];
    NSArray* suitArray = @[@"DIAMOND",@"SPADE",@"HEART",@"CLUB"];
    return [NSString stringWithFormat:@"Card: < %@, %@ >",numberArray[(int)self.number], suitArray[(int)self.suit] ];
}

@end
