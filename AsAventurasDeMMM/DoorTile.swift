//
//  DoorTile.swift
//  AsAventurasDeMMM
//
//  Created by Henrique de Abreu Amitay on 11/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit
class DoorTile:Tile{
    
    var openDoorTexture: UIImage!
    var closedDoorTexture: UIImage!
    var locked = true
    
    override init(){
        openDoorTexture = UIImage(named: "PastDoor_Unlocked_Horizontal")
        closedDoorTexture = UIImage(named: "PastDoor_Locked_Horizontal")
        super.init()
        texture = SKTexture(CGImage: closedDoorTexture.CGImage!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
