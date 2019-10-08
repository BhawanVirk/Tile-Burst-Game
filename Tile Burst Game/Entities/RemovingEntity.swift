//
//  RemovingEntity.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-10-01.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import GameplayKit
import SpriteKit

class NodeRemover : GKEntity {
    init(nodeToRemove: SKNode, scene: SKScene) {
        super.init()
        
        let button = ButtonNode(label: "Remove Now") {
            nodeToRemove.removeFromParent()
        }
        button.position = CGPoint(x: 0, y: UIScreen.main.bounds.size.height/2)
        scene.addChild(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
