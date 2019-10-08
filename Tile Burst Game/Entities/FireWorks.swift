//
//  FireWorks.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-10.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import GameplayKit
import SpriteKit

class Fireworks: GKEntity, PersonalTouchAwareEntity {
    
    private(set) weak var scene: SKScene!
    private var _sparkFX: SKEmitterNode?
    
    init(scene: SKScene) {
        self.scene = scene
        self._sparkFX = SKEmitterNode(fileNamed: "Spark.sks")!
        super.init()
        
        _sparkFX?.position = .zero
        _sparkFX?.targetNode = scene
        _sparkFX?.particleBirthRate = 0
        if _sparkFX != nil {
            scene.addChild(_sparkFX!)
        }
        
        addComponent(Draggable(node: _sparkFX))
        
        // configure personal area
        let screenSize = getScreenSize()
        personalAreaNode = SKShapeNode(rectOf: CGSize(width: screenSize.width, height: screenSize.height - 250))
        personalAreaNode.fillColor = .red
        personalAreaNode.lineWidth = 0
        personalAreaNode.position = CGPoint(x: 0, y: 0)
//        scene.addChild(personalAreaNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Handling Personal Touches
    var personalAreaNode: SKShapeNode = SKShapeNode()
    var touchExitedArea: Bool = false
    
    func personalTouchBegan(_ touch: UITouch) {
        component(ofType: Draggable.self)?.start(from: touch.location(in: scene))
        _sparkFX?.particleBirthRate = 2000
    }
    
    func personalTouchMoved(_ touch: UITouch) {
        component(ofType: Draggable.self)?.touchMoved(to: touch.location(in: scene), previousLocation: touch.previousLocation(in: scene))
    }
    
    func personalTouchEnded(_ touch: UITouch) {
        _sparkFX?.particleBirthRate = 0
    }
}
