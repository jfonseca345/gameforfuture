//
//  GameScene.m
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 09/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "GameScene.h"
#import "AsAventurasDeMMM-Swift.h"
#import "buttonPad.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    /*SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];*/
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    MapNode* map = [[MapNode alloc] initWithBackgroundTexture:[SKTexture textureWithImageNamed:@"dungeon1"]];
    [self addChild:map];
    [map centerOnNode];
    AnalogGesture * gameAnalogic;
    gameAnalogic = [[AnalogGesture alloc] initWithTarget:self action:@selector(directionChanged:) scene:self];
    [self.view addGestureRecognizer:gameAnalogic];
    self.heroPosition = CGPointMake(50, 50);
    buttonPad * btp;
    btp = [[buttonPad alloc] init];
    [self addChild:btp];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self updateHero];
    
}
- (void)directionChanged:(AnalogGesture * )sender
{
    NSLog(@"%ld",(long)sender.analogDirection);
    self.heroDirection = sender.analogDirection;
}

-(void) updateHero{
        MapNode* map = (MapNode*)[self childNodeWithName:@"world"];
        SKNode* camera = [self childNodeWithName:@"//camera"];
        SKSpriteNode* heroTile = (SKSpriteNode*)[self childNodeWithName:@"//HeroTile"];
        
        /*if (self.walking == 0 ){
         if (camera.position.x< (map.size.width-320)){
         camera.position = CGPointApplyAffineTransform(camera.position, CGAffineTransformMakeTranslation(256, 0));
         }
         else{
         camera.position = CGPointMake(camera.position.x, camera.position.y+256);
         self.walking = 1;
         }
         }
         else{
         if (camera.position.x >= -320){
         camera.position = CGPointApplyAffineTransform(camera.position, CGAffineTransformMakeTranslation(-256, 0));
         }
         else{
         camera.position = CGPointMake(camera.position.x, camera.position.y+256);
         self.walking = 0;
         }
         }*/
        BOOL canWalk = [map verifyPosition:self.heroPosition direction:self.heroDirection];
    
        if (canWalk){
            switch (self.heroDirection) {
                case ANALOG_UP:
                    self.heroPosition = CGPointMake(self.heroPosition.x, self.heroPosition.y-1);
                    break;
                    
                case ANALOG_LEFT:
                    self.heroPosition = CGPointMake(self.heroPosition.x-1, self.heroPosition.y);
                    break;
                    
                case ANALOG_RIGHT:
                    self.heroPosition = CGPointMake(self.heroPosition.x+1, self.heroPosition.y);
                    break;
                    
                case ANALOG_DOWN:
                    self.heroPosition = CGPointMake(self.heroPosition.x, self.heroPosition.y+1);
                    break;
                
                default:
                    break;
            }
        }

        
        camera.position = [map convertFromTileToMap:self.heroPosition];
        heroTile.position = CGPointMake(camera.position.x, camera.position.y);
        [map centerOnNode];
        
        
    }

@end
