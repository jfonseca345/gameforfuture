//
//  WeaponFactory.swift
//  AsAventurasDeMMM
//
//  Created by Henrique de Abreu Amitay on 10/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit

class WeaponFactory{
    
//Creates randomized weapons

    //We list all the possible weapon names and their respectives base powers, based on the time Period
    let pastWeaponNames: [String] = ["Club","Slingshot","Spear"] //2,3,4
    
    let presentWeaponNames: [String] = ["Machete","Gun","Spellbook"] //4,5,6
    
    let futureWeaponNames: [String] = ["Laser Sword","Plasma Rifle","Alien Thrower"] //6,7,8
    
    //Weapons can have adjective based on it's power
    
    let weaponAdjectives: [String] = ["Broken", "Poor", "Average", "Well Done", "Great"] //-2,-1,0,+1,+2
    
    
    func createWeaponOfPeriod(period: Period)->Weapon
    {
        //First let us roll which weapon shall be generated
        let weaponIndex: Int = Int(arc4random_uniform(3))
        
        //Now let us give a quality to the weapon
        let weaponQuality: Int = rollQuality();
        
        //Weapons Attributes
        var weaponName: String
        var weaponBonus: Int
        var weaponIcon: UIImage
        
        switch (period)
        {
            case .Past:
            weaponName = weaponAdjectives[weaponQuality]
            weaponName += pastWeaponNames[weaponIndex]
            weaponBonus = (weaponIndex+2) + (weaponQuality-2)
            
            //The weapon Icon is linked to its name
            weaponIcon = UIImage(named: pastWeaponNames[weaponIndex])!
            
            case .Present:
            weaponName = weaponAdjectives[weaponQuality]
            weaponName += presentWeaponNames[weaponIndex]
            weaponBonus = (weaponIndex+4) + (weaponQuality-2)
            
            //The weapon Icon is linked to its name
            weaponIcon = UIImage(named: presentWeaponNames[weaponIndex])!
            
            case .Future:
            weaponName = weaponAdjectives[weaponQuality]
            weaponName += futureWeaponNames[weaponIndex]
            weaponBonus = (weaponIndex+6) + (weaponQuality-2)
            
            //The weapon Icon is linked to its name
            weaponIcon = UIImage(named: futureWeaponNames[weaponIndex])!
        }
        
        var weapon: Weapon = Weapon(weaponName: weaponName, weaponIcon: weaponIcon, weaponBonus: weaponBonus)
        
        return weapon
    }
    
    
    func rollQuality()->Int
    {
        /*Rolls the quality of the weapon, with the following chances
            Great (4) -> 10%    Check if number is divisible by 6
            Well Done (3) -> 15%    Check if number is divisible by 3
            Average (2) -> 20%  Check if number is divisible by 5
            Poor (1) -> 35%     Check if number is even
            Broken(0) -> 30%    Check if number is odd
        
        */
        
        let diceRoll: Int = Int(arc4random_uniform(21)) //Rolls a number from 0 to 20
        
        //We pass the number through filters
        
        //Filter 1: is the number divisible by 6? 10%  chance
            if(diceRoll%6 == 0 && diceRoll != 0){
            return 4;}
        
        //Filter 2: is the number divisible by 5? 20% chance
            if(diceRoll%5 == 0 && diceRoll != 0){
                return 2;
        }
        
        //Filter 3: Is the number divisible by 3? 15% chance
            if(diceRoll%3 == 0 && diceRoll != 0){
                return 3
        }
        
        //Filter 4: Is the number even? 35% chance
            if(diceRoll%2==0){
                return 1;
        }
        
        //Filter 5: Is the number odd? 30% chance
        return 0;
    }
    
}
