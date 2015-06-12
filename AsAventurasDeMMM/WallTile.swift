//
//  WallTile.swift
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 12/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit

class WallTile: Tile {
    override func setPeriod(period:Period){
        switch (period)
        {
        case .Past:
            self.texture = SKTexture(imageNamed: "pastWallTexture")
        case .Present:
            self.texture = SKTexture(imageNamed: "presentWallTexture")
        case .Future:
            self.texture = SKTexture(imageNamed: "futureWallTexture")
        }
    }
}
