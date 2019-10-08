//
//  Stretch.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-04.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import GameplayKit
import SpriteKit

class Stretch: GKComponent {
    var node: SKNode
    var x: CGFloat = 2
    var y: CGFloat = 1.25
    var duration: TimeInterval = 0.5
    
    private var _oneRoundAnimation: SKAction {
        return SKAction.sequence([SKAction.scaleX(to: x, y: y, duration: duration/2), SKAction.scale(to: 1, duration: duration/2)])
    }
    
    init(node: SKNode) {
        self.node = node
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func oneway() {
        node.run(SKAction.scaleX(to: x, y: y, duration: duration))
    }
    
    func oneRound() {
        node.run(_oneRoundAnimation)
    }
    
    func loop() {
        node.run(SKAction.repeatForever(_oneRoundAnimation))
    }
}
