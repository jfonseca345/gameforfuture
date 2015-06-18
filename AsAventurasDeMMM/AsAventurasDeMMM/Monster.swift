//
//  Monster.swift
//  MonsterFactory
//
//  Created by Henrique de Abreu Amitay on 09/06/15.
//  Copyright (c) 2015 Henrique de Abreu Amitay. All rights reserved.
//

import UIKit

@objc class Monster: IsAPlayerProtocol{
    
    //Monster Graphical Attributes
    var name: String
    var mapImage: UIImage
    var battleImage: UIImage
    
    //Monster Stats
    var HP: Int
    var Atk: Int
    var Def: Int

    //Monster Loot
    var XP: Int
    var Gold: Int
    
    func cardsToTrade() -> Int32 {
        return 0;
    }
    func move() -> myMove {
        let move = myMove();
        return move;
    }
    
    //Initiation Method
    init(monsterWithName: String, MapImage: UIImage, BattleImage: UIImage, hp: Int, atk: Int, def: Int, xp: Int, gold: Int)
    {
        self.name = monsterWithName
        self.mapImage = MapImage
        self.battleImage = BattleImage
        self.HP = hp
        self.Atk = atk
        self.Def = def
        self.XP = xp
        self.Gold = gold
    }
    
}