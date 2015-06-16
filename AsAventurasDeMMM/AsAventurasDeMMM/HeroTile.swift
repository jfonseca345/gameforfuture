//
//  HeroTile.swift
//  AsAventurasDeMMM
//
//  Created by Henrique de Abreu Amitay on 12/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit

class HeroTile: Tile{
    
    var hero: Hero
    
    init(hero: Hero)
    {
        self.hero = hero
        super.init()
        
        self.texture = SKTexture(image: self.hero.heroMapImage)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}