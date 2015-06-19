//
//  pokerButtonPad.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/19/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@protocol pokerButtonPadDelegate <NSObject>

- (void) aButtonTapped;
- (void) bButtonTapped;
- (void) cButtonTapped;

@end

@interface pokerButtonPad : SKNode

@property (weak) id <pokerButtonPadDelegate> delegate;

@end
