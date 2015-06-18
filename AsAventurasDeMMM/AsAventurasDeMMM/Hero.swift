//
//  AbstractHero.swift
//  AsAventurasDeMMM
//
//  Created by Henrique de Abreu Amitay on 12/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit
@objc class Hero: IsAPlayerProtocol{
    
    //Hero
    var heroName: String = "DEFAULT_NAME"
    
    //NumericalStats
    var lvl: Int = 1
    var hp: Int = 5
    var atk: Int = 1
    var def: Int = 1
    var currentExp: Int = 0
    
    //Equipment
    //var weapon: Weapon = Weapon(weaponName: "Fist", weaponIcon: UIImage(named: "Fist")!, weaponBonus: 0)
    //var item1: Item   IMPLEMENTAR
    //var item2: Item   IMPLEMENTAR
    var gold: Int = 0
    
    let heroMapImage: UIImage = UIImage(named: "Hero")!
    
    //Init, not used yet
    init()
    {
        
    }
    
    func cardsToTrade() -> Int32 {
        return 0;
    }
    func move() -> myMove {
        let move = myMove();
        return move;
    }
    
    //Hero Methods, to be implemented
    
    /*func changeWeapon(weapon: Weapon)
    {
        self.weapon = weapon
    }*/
    
    //Checks current XP, and avaliates if character has to go up a level
    func checkEXP()
    {
        //PLACEHOLDER
        if(self.currentExp == (self.lvl*10)+((self.lvl+1)*5))
        {
            self.currentExp = 0
            upLevel()
        }
    }
    
    func upLevel()
    {
        //PLACEHOLDER
        self.lvl++
        self.hp += 3
        self.atk++
        self.def++
    }
}
