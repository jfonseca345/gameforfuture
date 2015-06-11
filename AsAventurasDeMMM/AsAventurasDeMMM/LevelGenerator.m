//
//  LevelGenerator.m
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/10/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "LevelGenerator.h"

@implementation LevelGenerator
+ (int) numberOfOccurencesOf:(char)charac nearby:(char[100][100]) matrix inX:(int)x andY:(int)y
{
    //Assuming a matrix of 100x100, returns the number of 'carac' that appears nearby
    int count = 0;
    if (x > 0 && matrix[x-1][y] == charac) count++;
    if (y > 0 && matrix[x][y-1] == charac) count++;
    if (x < 99 && matrix[x+1][y] == charac) count++;
    if (y < 99 && matrix[x][y+1] == charac) count++;
    if (x > 0 && y > 0 && matrix[x-1][y-1] == charac) count++;
    if (x > 0 && y < 99 && matrix[x-1][y+1] == charac) count++;
    if (x < 99 && y > 0 && matrix[x+1][y-1] == charac) count++;
    if (x < 99 && y < 99 && matrix[x+1][y+1] == charac) count++;
    return count;
}

+ (NSArray *) randomizeLevel:(int)levelNumber withWeak:(int)weakCount medium:(int)mediumCount strong:(int)strongCount
{ //Verifica quantos spawns de cada tipo tem, ve a media de monstro por spawn e sempre atualiza o contador e aleatoriza, multiplica probabilidade..
    //Contagem de spawns buga em alguns casos. tipo 00077/n77777, conta como 2
    int i, j;
    int currWeak = 0, currMedium = 0, currStrong = 0;
    int weakSpawnCount = 0, mediumSpawnCount = 0, strongSpawnCount = 0;
    float weakAvr = 0, mediumAvr = 0, strongAvr = 0;
    char map[100][100] = {0};
    char randomizedMap[100][100] = {0};
    NSString * levelName = @"model";
    switch (levelNumber) {
        case 1:
            levelName = [levelName stringByAppendingString:@"1"];
            break;
        default:
            return nil;
            break;
    }
    NSString * levelPath = [[NSBundle mainBundle] pathForResource:levelName ofType:@"level"];
    NSString * levelString = [[NSString alloc] initWithContentsOfFile:levelPath usedEncoding:nil error:nil];
    NSArray * lines = [levelString componentsSeparatedByString:@"\n"];
    
    for (i = 0; i < 100; i++)
    {
        for (j = 0; j < 100; j++)
        {
            if ([lines[i] characterAtIndex:j] == '5')
            {
                map[i][j] = '%';
                if (![self numberOfOccurencesOf:'%' nearby:map inX:i andY:j]) weakSpawnCount++;
            }
            else if ([lines[i] characterAtIndex:j] == '6')
            {
                map[i][j] = '^';
                if (![self numberOfOccurencesOf:'^' nearby:map inX:i andY:j]) mediumSpawnCount++;
            }
            else if ([lines[i] characterAtIndex:j] == '7')
            {
                map[i][j] = '&';
                if (![self numberOfOccurencesOf:'&' nearby:map inX:i andY:j]) strongSpawnCount++;
            }
            else map[i][j] = [lines[i] characterAtIndex:j];
        }
    }
    weakAvr = (float)weakCount/weakSpawnCount;
    mediumAvr = (float)mediumCount/mediumSpawnCount;
    strongAvr = (float)strongCount/strongSpawnCount;
    
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
                        if ((arc4random_uniform(201)/100.)+weakAvr > 1)
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
                        if ((arc4random_uniform(201)/100.)+mediumAvr > 1)
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
                        if ((arc4random_uniform(201)/100.)+strongAvr > 1)
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
        weakAvr = (float)weakCount/weakSpawnCount;
        mediumAvr = (float)mediumCount/mediumSpawnCount;
        strongAvr = (float)strongCount/strongSpawnCount;
    }
    
    NSMutableArray * retval;
    retval = [[NSMutableArray alloc] init];
    for (i = 0; i < 100; i++) {
        [retval addObject:[[NSMutableArray alloc] init]];
    }
    for (i = 0; i < 100; i++)
    {
        for (j = 0; j < 100; j++)
        {
            
            [retval[i] addObject:[NSString stringWithFormat:@"%c",randomizedMap[i][j]]];
        }
    }
    
    return retval;
}
@end
