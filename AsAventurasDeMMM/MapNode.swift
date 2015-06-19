//
//  MapNode.swift
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 10/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import SpriteKit

@objc
class MapNode: SKSpriteNode {

    private var mapContent:[[String]]=[[""]]
    private var mapMovable:[[String]]=[[""]]
    var heroInitialPosition:CGPoint!
    var moveCount = 0
    
    @objc(initWithBackgroundTexture:)
    init(backgroundTexture:SKTexture){
        
        super.init(texture: backgroundTexture, color: UIColor.clearColor(), size: backgroundTexture.size())
        let camera = SKSpriteNode()
        camera.position = CGPoint(x: 320, y: 320)
        camera.name = "camera"
        self.addChild(camera)
        //self.size = CGSize(width: 640, height: 640)
        //centerOnNode()
        self.name = "world"
        addFromMap(LevelGenerator.randomizeLevel(1, withWeak: 5, medium: 5, strong: 5) as! [[String]], period: Period.Past)
        self.anchorPoint = CGPointZero
    }

    
    @objc
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setBackground(backgroundTexture:SKTexture){
        self.texture = backgroundTexture        
    }
    
    func addFromMap(charMap: [[String]], period: Period){
        
        self.size = CGSize(width: charMap.count * 64, height: charMap[0].count * 64)
        
        mapContent = [[String]](count: charMap.count, repeatedValue: [String](count: charMap[0].count, repeatedValue: "0"))
        mapMovable = [[String]](count: charMap.count, repeatedValue: [String](count: charMap[0].count, repeatedValue: "0"))
        
        for y in 0..<charMap.count{
            for x in 0..<charMap[y].count{
                let tilePosition = CGPoint(x: x * 64, y: (charMap.count - 1 - y) * 64)
                let tile = TileFactory.createTile(charMap[y][x], tilePosition: tilePosition, period: period)
                addChild(tile)
                
                if (needBackground(charMap[y][x])){
                    let floorTile = TileFactory.createTile("0", tilePosition: tilePosition, period: period)
                    addChild(floorTile)
                    
                }
                
                
                if (charMap[y][x] == "@"){
                    heroInitialPosition = CGPoint(x: x, y: y)
                    let camera = childNodeWithName("camera")
                    camera!.position = convertFromTileToMap(heroInitialPosition)
                }
                
                if (isMovable(charMap[y][x])){
                    mapMovable[y][x] = charMap[y][x]
                }
                else{
                    mapContent[y][x] = charMap[y][x]
                }
            }
        }
    }
    
    //Center camera in Scene
    @objc
    func centerOnNode(){
        let cameraNode = self.childNodeWithName("camera")
        let node = cameraNode!
        let cameraPositionInScene = node.scene!.convertPoint(node.position, fromNode: self)

        let walkAction = SKAction.moveTo(CGPoint(x: self.position.x - cameraPositionInScene.x, y: self.position.y - cameraPositionInScene.y), duration: 0.1)
        
        self.runAction(walkAction);
        
        if (moveCount == 40){
            for y in 0..<mapMovable.count{
                for x in 0..<mapMovable[y].count{
                    if (mapMovable[y][x] != "0" && mapMovable[y][x] != "@" && mapMovable[y][x] != "-" && count(mapMovable[y][x]) != 2){
                        mapMovable[y][x] = mapMovable[y][x]+"d"
                        moveMonsters(x, y:y)
                    }
                }
            }
            
            for y in 0..<mapMovable.count{
                for x in 0..<mapMovable[y].count{
                    if (count(mapMovable[y][x]) == 2){
                        mapMovable[y][x] = mapMovable[y][x].substringToIndex(advance(mapMovable[y][x].startIndex,1))
                    }
                }
            }
        
            moveCount = 0
        }
        moveCount = moveCount + 1
        //self.position = CGPoint(x: , y: self.position.y - cameraPositionInScene.y)
    }
    
    @objc
    func verifyPosition(actualPosition:CGPoint, direction: analogDirectionTypes)->Bool{
        switch(direction){
            case .ANALOG_RIGHT:
                if ((Int(actualPosition.x) + 1 < self.mapContent[Int(actualPosition.y)].count) &&  (isWalkable(self.mapContent[Int(actualPosition.y)][Int(actualPosition.x) + 1])) && (isWalkable(self.mapMovable[Int(actualPosition.y)][Int(actualPosition.x) + 1]))) {
                    return true
                }
            
            case .ANALOG_UP:
                if ((Int(actualPosition.y) - 1 >= 0) &&
                    (isWalkable(self.mapContent[Int(actualPosition.y) - 1][Int(actualPosition.x)])) &&
                    (isWalkable(self.mapMovable[Int(actualPosition.y) - 1][Int(actualPosition.x)]))){
                    return true
                }
            
            case .ANALOG_LEFT:
                if ((Int(actualPosition.x) - 1 >= 0) &&
                    (isWalkable(self.mapContent[Int(actualPosition.y)][Int(actualPosition.x) - 1])) &&
                    (isWalkable(self.mapMovable[Int(actualPosition.y)][Int(actualPosition.x) - 1]))){
                    return true
                }
            
            case .ANALOG_DOWN:
                if ((Int(actualPosition.y) + 1 < self.mapContent.count) &&
                    (isWalkable(self.mapContent[Int(actualPosition.y) + 1][Int(actualPosition.x)])) &&
                    (isWalkable(self.mapMovable[Int(actualPosition.y) + 1][Int(actualPosition.x)]))){
                    return true
                }
            
            case .ANALOG_ZERO:
                return true
            
            default:
                return false
        
        }
        
        return false
    }
    
    @objc
    func convertFromTileToMap(point: CGPoint)->CGPoint{
        let pointX = Int(point.x)
        let pointY = (mapContent.count - 1 - Int(point.y)) * 64
        return CGPoint(x: pointX * 64, y: pointY)
    }
    
    func isWalkable(charTile: String) -> Bool{
        switch(charTile){
            case "0":
            return true
    
            case "b":
            return true
            
            case "=", "9":
            return true
            
            default:
            return false
        }
    }
    
    func isMovable(charTile:String)->Bool{
        switch(charTile){
        case "%", "^", "&":
            return true
            
        case "@", "-":
            return true
            
        default:
            return false
        }
    }
    
    func needBackground(charTile:String)->Bool{
        switch(charTile){
        case "%", "^", "&":
            return true
            
        case "@", "-":
            return true
        
        case "=", "9", "8":
            return true
            
        case "2", "3", "4":
            return true
            
        default:
            return false
        }
    }
    
    func moveMonsters(x: Int, y: Int){
        var mx = 0
        var my = 0
        
        if (x < Int(heroInitialPosition.x)){
            mx = 1
        }
        else{
            mx = -1
        }
        
        if (y < Int(heroInitialPosition.y)){
            my = 1
        }
        else{
            my = -1
        }
        
        let zero = arc4random_uniform(100)%2
        
        if (zero == 0){
            mx = 0
        }
        else{
            my = 0
        }
        
        if (isWalkable(mapContent[y+my][x+mx]) &&
            isWalkable(mapMovable[y+my][x+mx])){
            mapMovable[y+my][x+mx] = mapMovable[y][x]
            mapMovable[y][x] = "0"
                
            let tiles = nodesAtPoint(CGPointApplyAffineTransform(convertFromTileToMap(CGPoint(x: x, y: y)), CGAffineTransformMakeTranslation(32, 32)) )
            println(tiles.count)

            for tilit in tiles{
                let tile = tilit as! SKNode
                if (tile.zPosition == 2){
                    tile.position = convertFromTileToMap(CGPoint(x:x + mx,y:y + my))
                    break
                }
            }
        }
    }
    
    @objc func getHeroInitialPosition() -> CGPoint{
        return heroInitialPosition!
    }
    
    @objc func setHeroPosition(heroPosition: CGPoint){
        mapMovable[Int(heroInitialPosition.y)][Int(heroInitialPosition.x)] = "0"
        mapMovable[Int(heroPosition.y)][Int(heroPosition.x)] = "@"
        heroInitialPosition = heroPosition
    }
    
    @objc func checkCombatCollision(collisionPoint: CGPoint) -> MonsterTile! {
        switch( mapMovable[Int(collisionPoint.y)][Int(collisionPoint.x)]){
            case "%", "^", "&":
                let tiles = nodesAtPoint(CGPointApplyAffineTransform(convertFromTileToMap(collisionPoint), CGAffineTransformMakeTranslation(32, 32)))
                for tilit in tiles{
                    let tile = tilit as! SKNode
                    if (tile.zPosition == 2){
                        return tile as! MonsterTile
                    }
                }
        
            default:
                return nil
        }
        return nil
    }
}
