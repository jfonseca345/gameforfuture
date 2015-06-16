//
//  TileFactory.swift
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 16/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import UIKit

class TileFactory: Tile {
    class func createTile(type:String, tilePosition:CGPoint, period:Period)->Tile{
        switch(type){
            
            case "1", "2", "3","4":
                let wallTile = WallTile()
                wallTile.setPeriod(period)
                wallTile.anchorPoint = CGPointZero
                wallTile.position = tilePosition
                wallTile.zPosition = 1
                return wallTile
            
            case "0":
                let floorTile = Tile()
                floorTile.setPeriod(period)
                floorTile.anchorPoint = CGPointZero
                floorTile.position = tilePosition
                floorTile.zPosition = 0
                return floorTile
            
            case "%":
                //let easyMonster = MonsterFactory.createEasyMonster(.Past)
                //let easyTile = MonsterTile(monster: easyMonster)
                let easyTile = Tile()
                easyTile.texture = SKTexture(imageNamed: "Easy")
                easyTile.anchorPoint = CGPointZero
                easyTile.position = tilePosition
                easyTile.zPosition = 1
                return easyTile
            
            
            case "^":
                //let mediumMonster = MonsterFactory.createMediumMonster(.Past)
                //let mediumTile = MonsterTile(monster: mediumMonster)
                let mediumTile = Tile()
                mediumTile.texture = SKTexture(imageNamed: "Medium")
                mediumTile.anchorPoint = CGPointZero
                mediumTile.position = tilePosition
                mediumTile.zPosition = 1
                return mediumTile
            
            case "&":
                //let bossMonster = MonsterFactory.createBoss(.Past)
                //let bossTile = MonsterTile(monster: bossMonster)
                let bossTile = Tile()
                bossTile.texture = SKTexture(imageNamed: "B0ss")
                bossTile.anchorPoint = CGPointZero
                bossTile.position = tilePosition
                bossTile.zPosition = 1
                return bossTile
            
            case "b":
                let bridgeTile = Tile()
                bridgeTile.setPeriod(period)
                bridgeTile.anchorPoint = CGPointZero
                bridgeTile.position = tilePosition
                bridgeTile.zPosition = 0
                return bridgeTile
            
            case "@":
                //let heroTile = HeroTile(hero: Hero())
                let heroTile = Tile()
                heroTile.texture = SKTexture(imageNamed: "Hero")
                heroTile.anchorPoint = CGPointZero
                heroTile.position = tilePosition
                heroTile.zPosition = 2
                heroTile.name = "HeroTile"
                return heroTile
            
            case "w":
                let waterTile = Tile()
                waterTile.texture = SKTexture(imageNamed: "pastObstacle")
                waterTile.anchorPoint = CGPointZero
                waterTile.position = tilePosition
                waterTile.zPosition = 0
                return waterTile
            
            case "-":
                let doorTile = DoorTile()
                doorTile.anchorPoint = CGPointZero
                doorTile.position = tilePosition
                doorTile.zPosition = 1
                return doorTile
            
            case "=":
                let npcTile = Tile()
                npcTile.texture = SKTexture(imageNamed: "ZombieSprite")
                npcTile.anchorPoint = CGPointZero
                npcTile.position = tilePosition
                npcTile.zPosition = 0
                return npcTile
            
            default:
            
                let floorTile = Tile()
                floorTile.setPeriod(period)
                floorTile.anchorPoint = CGPointZero
                floorTile.position = tilePosition
                floorTile.zPosition = 0
                return floorTile
        }

    }
}
