//
//  Bhawan.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-03.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import GameplayKit
import SpriteKit

class Square: GKEntity {
    var node: SKNode
    
    init(node: SKNode) {
        self.node = node
        super.init()
        
        /*
        let pulseComponent = Pulse(node: self.node)
        pulseComponent.scaleTo = 1.5
        pulseComponent.duration = 0.1
        addComponent(pulseComponent)
        */
        
        // adding stretch component
        let stretchComponent = Stretch(node: self.node)
        stretchComponent.x = 7
        stretchComponent.y = 1
        addComponent(stretchComponent)
        
        // adding draggable component
        let draggableComponent = Draggable(node: self.node)
        addComponent(draggableComponent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Make it tap aware
extension Square: TapAwareEntity {
    func onTapReceived(at point: CGPoint) {
        component(ofType: Stretch.self)?.oneRound()
    }
}

// MARK:- Handle Touches
extension Square: SceneTouchAwareEntity {
    func sceneTouchBegan(_ touch: UITouch) {
        
    }
    
    func sceneTouchMoved(_ touch: UITouch) {
        if let scene = node.scene {
            component(ofType: Draggable.self)?.touchMoved(to: touch.location(in: scene), previousLocation: touch.previousLocation(in: scene))
        }
    }
    
    func sceneTouchEnded(_ touch: UITouch) {
        
    }
}
