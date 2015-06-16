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
                let tilePosition = CGPoint(x: x * 64, y: (charMap.count - 1 - y) * 64)
                let tile = TileFactory.createTile(charMap[y][x], tilePosition: tilePosition, period: period)
                addChild(tile)
                
                if (needBackground(charMap[y][x])){
                    let floorTile = TileFactory.createTile("0", tilePosition: tilePosition, period: period)
                    addChild(floorTile)
                    
                }
            }
        }

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
                if ((Int(actualPosition.x) + 1 < self.mapContent[Int(actualPosition.y)].count) &&  (isWalkable(self.mapContent[Int(actualPosition.y)][Int(actualPosition.x) + 1]))) {
                    return true
                }
            
            case .ANALOG_UP:
                if ((Int(actualPosition.y) - 1 >= 0) &&  (isWalkable(self.mapContent[Int(actualPosition.y) - 1][Int(actualPosition.x)]))){
                    return true
                }
            
            case .ANALOG_LEFT:
                if ((Int(actualPosition.x) - 1 >= 0) &&  (isWalkable(self.mapContent[Int(actualPosition.y)][Int(actualPosition.x) - 1]))){
                    return true
                }
            
            case .ANALOG_DOWN:
                if ((Int(actualPosition.y) + 1 < self.mapContent.count) &&  (isWalkable(self.mapContent[Int(actualPosition.y) + 1][Int(actualPosition.x)]))){
                    return true
                }
            
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
            
            case "-":
            return true
            
            case "@":
            return true
            
            default:
            return false
        }
    }
    
    func needBackground(charTile:String)->Bool{
        switch(charTile){
        case "%":
            return true
            
        case "^":
            return true
            
        case "&":
            return true
            
        case "@":
            return true
        
        case "-":
            return true
            
        default:
            return false
        }
    }
}
