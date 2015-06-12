//
//  MonsterFactory.swift
//  MonsterFactory
//
//  Created by Henrique de Abreu Amitay on 09/06/15.
//  Copyright (c) 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit

class MonsterFactory{
    
    //Used to create monsters
    
    class func createEasyMonster(onPeriod: Period) -> Monster
    {
        var easyMonster: Monster
        
        //Monster Graphical Setup
        var monsterName: String
        var monsterMapImage: UIImage
        var monsterBattleImage: UIImage
        
        //Monster Version, we have differents sprites for easy monsters
        let monsterVersion = arc4random_uniform(2)
        
        //Sprites and Names change based on time period
        switch onPeriod{
        case .Past:
            if(monsterVersion == 0)
            {
               monsterName = "Giant Dragonfly"
               monsterMapImage = UIImage(named: "past_easy1")!
               monsterBattleImage = UIImage(named: "past_easy1")!
            }
            else
            {
                monsterName = "Carnivorous Plant"
                monsterMapImage = UIImage(named: "past_easy2")!
                monsterBattleImage = UIImage(named: "past_easy2")!
            }
        
        case .Present:
            if(monsterVersion == 0)
            {
                monsterName = "Stray Dog"
                monsterMapImage = UIImage(named: "prest_easy1")!
                monsterBattleImage = UIImage(named: "prest_easy1")!
            }
            else
            {
                monsterName = "EASY_PRESENTMONSTER2"
                monsterMapImage = UIImage(named: "prest_easy2")!
                monsterBattleImage = UIImage(named: "prest_easy2")!
            }
            
        
        case .Future:
            if(monsterVersion == 0)
            {
                monsterName = "EASY_FUTUREMONSTER1"
                monsterMapImage = UIImage(named: "future_easy1")!
                monsterBattleImage = UIImage(named: "future_easy1")!
            }
            else
            {
                monsterName = "EASY_FUTUREMONSTER2"
                monsterMapImage = UIImage(named: "future_easy2")!
                monsterBattleImage = UIImage(named: "future_easy2")!
            }
        }
        
        //Now, let us generate monsters stats
        var monsterHP = 2 + Int(arc4random_uniform(5)) //2~6
        var monsterAtk = 1 + Int(arc4random_uniform(3)) //1~3
        var monsterDef = 1 + Int(arc4random_uniform(3)) //1~3
        var monsterGold = monsterHP*2 + Int(arc4random_uniform(3)) //6~14
        var monsterXP = monsterHP*2 + Int(arc4random_uniform(3)) //6~14
        
        easyMonster = Monster(monsterWithName: monsterName
            , MapImage: monsterMapImage, BattleImage: monsterBattleImage, hp: monsterHP, atk: monsterAtk, def: monsterDef, xp: monsterXP, gold: monsterGold)
        
        return easyMonster
    }
    
    class func createMediumMonster(onPeriod: Period) -> Monster
    {
        var mediumMonster: Monster
        
        //Monster Graphical Setup
        var monsterName: String
        var monsterMapImage: UIImage
        var monsterBattleImage: UIImage
        
        //Monster Version, we have differents sprites for easy monsters
        let monsterVersion = arc4random_uniform(2)
        
        //Sprites and Names change based on time period
        switch onPeriod{
        case .Past:
            if(monsterVersion == 0)
            {
                monsterName = "Sabertooth"
                monsterMapImage = UIImage(named: "past_med1")!
                monsterBattleImage = UIImage(named: "past_med1")!
            }
            else
            {
                monsterName = "Mammoth"
                monsterMapImage = UIImage(named: "past_med2")!
                monsterBattleImage = UIImage(named: "past_med2")!
            }
            
        case .Present:
            if(monsterVersion == 0)
            {
                monsterName = "Cultist"
                monsterMapImage = UIImage(named: "prest_med1")!
                monsterBattleImage = UIImage(named: "prest_med1")!
            }
            else
            {
                monsterName = "Zombie"
                monsterMapImage = UIImage(named: "prest_med2")!
                monsterBattleImage = UIImage(named: "prest_med2")!
            }
            
            
        case .Future:
            if(monsterVersion == 0)
            {
                monsterName = "Alien"
                monsterMapImage = UIImage(named: "future_med1")!
                monsterBattleImage = UIImage(named: "future_med1")!
            }
            else
            {
                monsterName = "MEDIUM_FUTUREMONSTER2"
                monsterMapImage = UIImage(named: "future_med2")!
                monsterBattleImage = UIImage(named: "future_med2")!
            }
        }
        
        //Now, let us generate monsters stats
        var monsterHP = 7 + Int(arc4random_uniform(5)) //7~11
        var monsterAtk = 4 + Int(arc4random_uniform(3)) //4~6
        var monsterDef = 4 + Int(arc4random_uniform(3)) //4~6
        var monsterGold = monsterHP*2 + Int(arc4random_uniform(3)) //14~24
        var monsterXP = monsterHP*2 + Int(arc4random_uniform(3)) //14~24
        
        mediumMonster = Monster(monsterWithName: monsterName
            , MapImage: monsterMapImage, BattleImage: monsterBattleImage, hp: monsterHP, atk: monsterAtk, def: monsterDef, xp: monsterXP, gold: monsterGold)
        
        return mediumMonster
    }
    
    class func createBoss(onPeriod: Period) ->Monster
    {
        //Ey b0ss
        
        var bossMonster: Monster
        
        //Monster Graphical Setup
        var monsterName: String
        var monsterMapImage: UIImage
        var monsterBattleImage: UIImage
        
        //Sprites and Names change based on time period
        switch onPeriod{
        case .Past:
            
            monsterName = "T-Rex"
            monsterMapImage = UIImage(named: "past_boss")!
            monsterBattleImage = UIImage(named: "past_boss")!
            
        case .Present:
            
            monsterName = "Lovecraftian Horror"
            monsterMapImage = UIImage(named: "prest_boss")!
            monsterBattleImage = UIImage(named: "prest_boss")!
            
        case .Future:
            
            monsterName = "Cybernetic Death Kitty"
            monsterMapImage = UIImage(named: "future_boss")!
            monsterBattleImage = UIImage(named: "future_boss")!
            
        }
        
        //Now, let us generate monsters stats
        var monsterHP = 15 + Int(arc4random_uniform(6)) //15~20
        var monsterAtk = 7 + Int(arc4random_uniform(4)) //7~10
        var monsterDef = 7 + Int(arc4random_uniform(4)) //7~10
        var monsterGold = monsterHP*2 + Int(arc4random_uniform(11)) //30~40
        var monsterXP = monsterHP*2 + Int(arc4random_uniform(11)) //30~40
        
        bossMonster = Monster(monsterWithName: monsterName
            , MapImage: monsterMapImage, BattleImage: monsterBattleImage, hp: monsterHP, atk: monsterAtk, def: monsterDef, xp: monsterXP, gold: monsterGold)
        
        return bossMonster
    }
    
}
