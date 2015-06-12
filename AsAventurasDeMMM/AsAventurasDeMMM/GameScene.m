//
//  GameScene.m
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 09/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "GameScene.h"
#import "AsAventurasDeMMM-Swift.h"
#import "AnalogGesture.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    /*SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];*/
    
    MapNode* map = [[MapNode alloc] initWithBackgroundTexture:[SKTexture textureWithImageNamed:@"dungeon1"]];
    [self addChild:map];
    [map centerOnNode];
    AnalogGesture * gameAnalogic;
    gameAnalogic = [[AnalogGesture alloc] initWithTarget:self action:@selector(directionChanged:) scene:self];
    [self.view addGestureRecognizer:gameAnalogic];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    MapNode* map = (MapNode*)[self childNodeWithName:@"world"];
    SKNode* camera = [self childNodeWithName:@"//camera"];
    camera.position=CGPointApplyAffineTransform(camera.position, CGAffineTransformMakeTranslation(-1, -1));
    [map centerOnNode];
}
- (void)directionChanged:(AnalogGesture * )sender
{
    NSLog(@"%u",sender.analogDirection);
}

@end
