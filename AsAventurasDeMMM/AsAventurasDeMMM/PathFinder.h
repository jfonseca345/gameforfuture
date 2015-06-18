//
//  PathFinder.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/18/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface PathFinder : NSObject

typedef NS_ENUM(NSInteger, WayToGo)
{
    UP,
    LEFT,
    DOWN,
    RIGHT,
};


@end
