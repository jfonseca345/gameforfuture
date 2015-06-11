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
    }

    
    @objc
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setBackground(backgroundTexture:SKTexture){
        self.texture = backgroundTexture        
    }
    
    func addFromMap(charMap: [[String]]){
    }
    
    @objc
    func centerOnNode(){
        let cameraNode = self.childNodeWithName("camera")
        let node = cameraNode!
        let cameraPositionInScene = node.scene!.convertPoint(node.position, fromNode: self)
        
        self.position = CGPoint(x: self.position.x - cameraPositionInScene.x, y: self.position.y - cameraPositionInScene.y)
    }
}
