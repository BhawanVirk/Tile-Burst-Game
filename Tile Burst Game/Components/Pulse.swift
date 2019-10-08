//
//  PulseTouchBased.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-03.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import GameplayKit
import SpriteKit

class Pulse: GKComponent {
    public var scaleTo: CGFloat = 1.2
    public var duration: TimeInterval = 1
    
    private let _node: SKNode
    
    init(node: SKNode) {
        self._node = node
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pulse() {
        let pulseAnimation = SKAction.sequence([SKAction.scale(to: scaleTo, duration: duration/2), SKAction.scale(to: 1, duration: duration/2)])
        _node.run(pulseAnimation)
    }
}
