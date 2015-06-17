//
//  MonsterTile.swift
//  AsAventurasDeMMM
//
//  Created by Henrique de Abreu Amitay on 12/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit

class MonsterTile: Tile{
    
    var monster: Monster
    
    init(monster: Monster)
    {
        self.monster = monster
        super.init()
        
        //self.texture = SKTexture(imageNamed:"zombieSprite")
        self.texture = SKTexture(image: self.monster.mapImage)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}