//
//  LevelGenerator.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/10/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "LevelGenerator.h"

@implementation LevelGenerator
+ (char**) randomizeLevel:(int)levelNumber withWeak:(int)weakCount medium:(int)mediumCount strong:(int)strongCount
{ //Verifica quantos spawns de cada tipo tem, ve a media de monstro por spawn e sempre atualiza o contador e aleatoriza, multiplica probabilidade..
    int i, j;
    int currWeak = 0, currMedium = 0, currStrong = 0;
    int weakSpawnCount = 0, mediumSpawnCount = 0, strongSpawnCount = 0;
    int weakAvr = 0, mediumAvr = 0, strongAvr = 0;
    char map[100][100] = {0};
    char randomizedMap[100][100] = {0};
    NSString * levelPath = [[NSBundle mainBundle] pathForResource:@"model1" ofType:@"level"];
    NSString * levelString = [[NSString alloc] initWithContentsOfFile:levelPath usedEncoding:nil error:nil];
    NSArray * lines = [levelString componentsSeparatedByString:@"\n"];
    
    for (i = 0; i < 100; i++)
    {
        for (j = 0; j < 100; j++)
        {
            if ([lines[i] characterAtIndex:j] == '5')
            {
                map[i][j] = '%';
                if (!(i > 0) || map[i-1][j] != '%')
                {
                    if (!(i < 100) || map[i+1][j] != '%')
                    {
                        if (!(j > 0) || map[i][j-1] != '%')
                        {
                            if (!(j < 100) || map[i][j+1] != '%')
                            {
                                weakSpawnCount++;
                            }
                        }
                    }
                }
            }
            else if ([lines[i] characterAtIndex:j] == '6')
            {
                map[i][j] = '^';
                if (!(i > 0) || map[i-1][j] != '^')
                {
                    if (!(i < 100) || map[i+1][j] != '^')
                    {
                        if (!(j > 0) || map[i][j-1] != '^')
                        {
                            if (!(j < 100) || map[i][j+1] != '^')
                            {
                                mediumSpawnCount++;
                            }
                        }
                    }
                }
            }
            else if ([lines[i] characterAtIndex:j] == '7')
            {
                map[i][j] = '&';
                if (!(i > 0) || map[i-1][j] != '&')
                {
                    if (!(i < 100) || map[i+1][j] != '&')
                    {
                        if (!(j > 0) || map[i][j-1] != '&')
                        {
                            if (!(j < 100) || map[i][j+1] != '&')
                            {
                                strongSpawnCount++;
                            }
                        }
                    }
                }
            }
            else map[i][j] = [lines[i] characterAtIndex:j];
        }
    }

    for (i = 0; i < 100; i++)
    {
        for (j = 0; j < 100; j++)
        {
            switch (map[i][j]) {
                case '2':
                    if ((arc4random_uniform(4)+1)%4 == 0) randomizedMap[i][j] = '2';
                    else randomizedMap[i][j] = '0';
                    break;
                case '3':
                    if ((arc4random_uniform(3)+1)%3 == 0) randomizedMap[i][j] = '3';
                    else randomizedMap[i][j] = '0';
                    break;
                case '4':
                    if ((arc4random_uniform(2)+1)%2 == 0) randomizedMap[i][j] = '4';
                    else randomizedMap[i][j] = '0';
                    break;
                case '%':
                    if (weakCount > currWeak) {
                        if ((arc4random_uniform(5)+1)%5 == 0)
                        {
                            currWeak++;
                            randomizedMap[i][j] = '%';
                        }
                        else randomizedMap[i][j] = '0';
                    }
                    else randomizedMap[i][j] = '0';
                    break;
                case '^':
                    if (mediumCount > currMedium) {
                        if ((arc4random_uniform(5)+1)%5 == 0)
                        {
                            currMedium++;
                            randomizedMap[i][j] = '^';
                        }
                        else randomizedMap[i][j] = '0';
                    }
                    else randomizedMap[i][j] = '0';
                    break;
                case '&':
                    if (strongCount > currStrong) {
                        if ((arc4random_uniform(5)+1)%5 == 0)
                        {
                            currStrong++;
                            randomizedMap[i][j] = '&';
                        }
                        else randomizedMap[i][j] = '0';
                    }
                    else randomizedMap[i][j] = '0';
                    break;
    
                default:
                    randomizedMap[i][j] = map[i][j];
                    break;
            }
        }
    }
    
    return nil;
}
@end
