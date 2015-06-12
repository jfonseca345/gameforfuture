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
        addFromMap(LevelGenerator.randomizeLevel(1, withWeak: 3, medium: 3, strong: 1) as! [[String]], period: Period.Past)
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
        for y in 0..<charMap.count{
            for x in 0..<charMap[y].count{
                let tilePosition = CGPoint(x: (charMap[y].count - 1 - x) * 64, y: (charMap.count - 1 - y) * 64)
                switch(charMap[y][x]){
                    case "1":
                        let wallTile = WallTile()
                        wallTile.setPeriod(period)
                        wallTile.anchorPoint = CGPointZero
                        wallTile.position = tilePosition
                        wallTile.zPosition = 1
                        addChild(wallTile)
                    
                    case "0":
                        let floorTile = Tile()
                        floorTile.setPeriod(period)
                        floorTile.anchorPoint = CGPointZero
                        floorTile.position = tilePosition
                        floorTile.zPosition = 0
                        addChild(floorTile)
                    
                    case "%":
                        let easyTile = SKSpriteNode(texture: SKTexture(imageNamed: "Easy"), size: CGSize(width: 64, height: 64))
                        easyTile.anchorPoint = CGPointZero
                        easyTile.position = tilePosition
                        easyTile.zPosition = 1
                        addChild(easyTile)
                        let floorTile = Tile()
                        floorTile.setPeriod(period)
                        floorTile.anchorPoint = CGPointZero
                        floorTile.position = tilePosition
                        floorTile.zPosition = 0
                        addChild(floorTile)
                    
                    case "^":
                        let mediumTile = SKSpriteNode(texture: SKTexture(imageNamed: "Medium"), size: CGSize(width: 64, height: 64))
                        mediumTile.anchorPoint = CGPointZero
                        mediumTile.position = tilePosition
                        mediumTile.zPosition = 1
                        addChild(mediumTile)
                        let floorTile = Tile()
                        floorTile.setPeriod(period)
                        floorTile.anchorPoint = CGPointZero
                        floorTile.position = tilePosition
                        floorTile.zPosition = 0
                        addChild(floorTile)
                    
                    case "&":
                        let bossTile = SKSpriteNode(texture: SKTexture(imageNamed: "B0ss"), size: CGSize(width: 64, height: 64))
                        bossTile.anchorPoint = CGPointZero
                        bossTile.position = tilePosition
                        bossTile.zPosition = 1
                        addChild(bossTile)
                        let floorTile = Tile()
                        floorTile.setPeriod(period)
                        floorTile.anchorPoint = CGPointZero
                        floorTile.position = tilePosition
                        floorTile.zPosition = 0
                        addChild(floorTile)
                    
                    default:
                        let floorTile = Tile()
                        floorTile.setPeriod(period)
                        floorTile.anchorPoint = CGPointZero
                        floorTile.position = tilePosition
                        floorTile.zPosition = 0
                        addChild(floorTile)
                }
            }
        }
        
        let heroTile = SKSpriteNode(texture: SKTexture(imageNamed: "Hero"), size: CGSize(width: 64, height: 64))
        heroTile.anchorPoint = CGPointZero
        heroTile.position = convertFromTileToMap(CGPointZero)
        heroTile.zPosition = 1
        addChild(heroTile)
        
        
        mapContent = charMap
    }
    
    @objc
    func centerOnNode(){
        let cameraNode = self.childNodeWithName("camera")
        let node = cameraNode!
        let cameraPositionInScene = node.scene!.convertPoint(node.position, fromNode: self)
        
        self.position = CGPoint(x: self.position.x - cameraPositionInScene.x, y: self.position.y - cameraPositionInScene.y)
    }
    
    @objc
    func verifyPosition(actualPosition:CGPoint, direction: analogDirectionTypes)->Bool{
        switch(direction){
            case .ANALOG_RIGHT:
                if ((Int(actualPosition.x) + 1 < self.mapContent[Int(actualPosition.y)].count) &&  (self.mapContent[Int(actualPosition.y)][Int(actualPosition.x) + 1] == "0")) {
                    return true
                }
            
            case .ANALOG_UP:
                if ((Int(actualPosition.y) - 1 >= 0) &&  (self.mapContent[Int(actualPosition.y) - 1][Int(actualPosition.x)] == "0")){
                    return true
                }
            
            case .ANALOG_LEFT:
                if ((Int(actualPosition.x) - 1 >= 0) &&  (self.mapContent[Int(actualPosition.y)][Int(actualPosition.x) - 1] == "0")){
                    return true
                }
            
            case .ANALOG_DOWN:
                if ((Int(actualPosition.y) + 1 < self.mapContent.count) &&  (self.mapContent[Int(actualPosition.y) + 1][Int(actualPosition.x)] == "0")){
                    return true
                }
            
            default:
                return false
        
        }
        
        return false
    }
    
    @objc
    func convertFromTileToMap(point: CGPoint)->CGPoint{
        return CGPoint(x: (mapContent[Int(point.y)].count - 1 - Int(point.x)) * 64, y: (mapContent.count - 1 - Int(point.y)) * 64)
    }
}
