//
//  GameScene.m
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 09/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

#import "GameScene.h"
#import "AsAventurasDeMMM-Swift.h"
#import "CardCombatController.h"
#import "CombateScene.h"

@interface GameScene()

//@property CardCombatController * cardCombatController;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    /*SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];*/
    
    if (self.firstLoad == YES)
    {
        [self setup];
    }
    
    
    //SO PRA TESTAR A COMBAT SCENE, TIRAR DEPOOOOIS
    //[view presentScene:[[CombateScene alloc] initWithSize:self.size]  transition:SKTransitionDirectionUp];
}

-(void)setup
{
    self.walking = NO;
    self.heroDirection = ANALOG_ZERO;
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    MapNode* map = [[MapNode alloc] initWithBackgroundTexture:[SKTexture textureWithImageNamed:@"dungeon1"]];
    [self addChild:map];
    [map centerOnNode];
    self.heroPosition = [map getHeroInitialPosition];
    
    AnalogGesture * gameAnalogic;
    gameAnalogic = [[AnalogGesture alloc] initWithTarget:self action:@selector(directionChanged:) scene:self];
    [self.view addGestureRecognizer:gameAnalogic];
    
//    self.cardCombatController = [[CardCombatController alloc] init];
    
    buttonPad * btp;
    btp = [[buttonPad alloc] init];
    [btp setPosition:CGPointMake([UIScreen mainScreen].bounds.size.width/2, -[UIScreen mainScreen].bounds.size.height/2)];
    //    [btp setPosition:CGPointMake(100, 100)];
    NSLog(@"%f, %f", btp.position.x, btp.position.y);
    btp.delegate = self;
    [self addChild:btp];
    [self setFirstLoad:NO];
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
//    NSLog(@"%ld",(long)sender.analogDirection);
    self.heroDirection = sender.analogDirection;
}

-(void) updateHero{
    MapNode* map = (MapNode*)[self childNodeWithName:@"world"];
    SKNode* camera = [self childNodeWithName:@"//camera"];
    SKSpriteNode* heroTile = (SKSpriteNode*)[self childNodeWithName:@"//HeroTile"];
    
    if (!self.walking){
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
        else {
            MonsterTile* isCombat;
            switch (self.heroDirection) {
                case ANALOG_UP:
                    isCombat = [map checkCombatCollision:CGPointMake(self.heroPosition.x, self.heroPosition.y-1)];
                    break;
                    
                case ANALOG_LEFT:
                    isCombat = [map checkCombatCollision:CGPointMake(self.heroPosition.x-1, self.heroPosition.y)];
                    break;
                    
                case ANALOG_RIGHT:
                    isCombat = [map checkCombatCollision:CGPointMake(self.heroPosition.x+1, self.heroPosition.y)];
                    break;
                    
                case ANALOG_DOWN:
                    isCombat = [map checkCombatCollision:CGPointMake(self.heroPosition.x, self.heroPosition.y+1)];
                    break;
                    
                default:
                    break;
            }
            
            if (isCombat!=nil) {
                NSLog(@"Fight!");
//                NSLog(isCombat.monster.name);
                HeroTile * myHero = (HeroTile *) heroTile;
                CombateScene * newScene = [[CombateScene alloc] initWithSize:self.size andWithHeroTile:myHero andMonsterTile:isCombat];
                [newScene setParentScene:self.scene];
                [(SKView *)self.view presentScene: newScene transition:SKTransitionDirectionUp];
            }
        }
        if (self.heroDirection != ANALOG_ZERO){
            CGPoint cameraPosition = [map convertFromTileToMap:self.heroPosition];
            SKAction* walkAction = [SKAction moveTo:cameraPosition duration:0.15];
            [heroTile runAction:walkAction completion:^{self.walking = NO;}];
            [map setHeroPosition: self.heroPosition];
            self.walking = YES;
        }
    }
    camera.position = CGPointMake(heroTile.position.x + 32, heroTile.position.y + 32);
    
    [map centerOnNode];
    
}

-(void)aButtonTapped
{
//    NSLog(@"AAAA");
}

-(void)bButtonTapped
{
//    NSLog(@"BBBB");
}
@end
