//
//  buttonPad.h
//  AsAventurasDeMMM
//
//  Created by Carlos Eduardo Millani on 6/16/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@protocol buttonPadDelegate <NSObject>

- (void) aButtonTapped;
- (void) bButtonTapped;

@end

@interface buttonPad : SKNode

@property (weak) id <buttonPadDelegate> delegate;

@end
