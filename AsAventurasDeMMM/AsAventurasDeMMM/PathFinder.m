//
//  PathFinder.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/18/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "PathFinder.h"
#import "AsAventurasDeMMM-Swift.h"

@implementation PathFinder

+ (NSMutableArray *) findPathFrom:(CGPoint)A to:(CGPoint)B on:(MapNode *)Map
{
    return [self findPathFrom:A to:B on:Map minimumUntilNow:-1];
}

+ (NSMutableArray *) findPathFrom:(CGPoint)A to:(CGPoint)B on:(MapNode *)Map minimumUntilNow:(int)minPath
{
    NSLog(@"PATHFIND NAO IMPLEMENTADO AINDA, NAO UTILIZAR");
    return nil;
}

+ (NSMutableArray *) dummyFindPathFrom:(CGPoint)A to:(CGPoint)B on:(MapNode *)Map
{
    int deltaX = B.x - A.x;
    int deltaY = B.y - A.y;
    NSMutableArray * returnArray;
    returnArray = [[NSMutableArray alloc] init];
    CGFloat ratio = deltaX/deltaY;
    int i;
    while (abs(deltaX) > 0 && abs(deltaY) > 0)
    {
        for (i = 0; i < ratio; i++)
        {
//            [returnArray addObject:deltaX>0?nil:nil];
            
        }
        for (i = 0; i < (1/ratio); i++)
        {
            
        }
    }
    NSLog(@"PATHFIND NAO IMPLEMENTADO AINDA, NAO UTILIZAR");
    return returnArray;
}

@end
