//
//  MapNode.swift
//  AsAventurasDeMMM
//
//  Created by Jucelio Fonseca on 10/06/15.
//  Copyright (c) 2015 Archbold S.A. All rights reserved.
//

import SpriteKit

class MapNode: SKSpriteNode {
    var camera: SKShapeNode!
    
    @objc(initWithBackgroundTexture:)
    init(backgroundTexture:SKTexture){
        
        super.init(texture: backgroundTexture, color: UIColor.clearColor(), size: backgroundTexture.size())
        self.camera = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 640, height: 640))
        self.addChild(camera)
        self.size = self.camera.frame.size
        centerOnNode(self.camera)
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setBackground(backgroundTexture:SKTexture){
        self.texture = backgroundTexture        
    }
    
    func centerOnNode(node:SKNode){
        let cameraPositionInScene = node.scene!.convertPoint(node.position, fromNode: node.parent!)
        
        node.parent!.position = CGPointMake(node.parent!.position.x - cameraPositionInScene.x,                                       node.parent!.position.y - cameraPositionInScene.y);
    }
}
