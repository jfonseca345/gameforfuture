//
//  Weapon.swift
//  AsAventurasDeMMM
//
//  Created by Henrique de Abreu Amitay on 10/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit

class Weapon{
    
    //Weapon Atributes
    var name: String
    var weaponIcon: UIImage
    var atkBonus: Int
    
    //Initializer
    init(weaponName: String, weaponIcon: UIImage, weaponBonus: Int)
    {
        self.name = weaponName
        self.weaponIcon = weaponIcon
        self.atkBonus = weaponBonus
    }
    
    
}
