//
//  Draggable.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-04.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import GameplayKit
import SpriteKit

class Draggable: GKComponent {
    var node: SKNode?
    
    init(node: SKNode?) {
        self.node = node
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(from point: CGPoint) {
        node?.position = point
    }
    
    func touchMoved(to: CGPoint, previousLocation wasAt: CGPoint) {
        if let n = self.node {
            n.position = n.position - (wasAt - to)
        }
    }
}
