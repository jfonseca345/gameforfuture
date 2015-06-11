//
//  Tile.swift
//  AsAventurasDeMMM
//
//  Created by Henrique de Abreu Amitay on 11/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit
import SpriteKit

protocol TileProtocol
{
    func setPeriod(period : Period)
}

class Tile: SKSpriteNode, TileProtocol{
    
    init()
    {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(64, 64))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setPeriod(period: Period) {
    //Set the tile Texture, based on the Time period
        
        switch (period)
        {
            case .Past:
                self.texture = SKTexture(imageNamed: "pastFloorTexture")
            case .Present:
                self.texture = SKTexture(imageNamed: "presentFloorTexture")
            case .Future:
                self.texture = SKTexture(imageNamed: "futureFloorTexture")
        }
        
    }
}