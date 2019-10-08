//
//  GameScene.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-08-28.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        backgroundColor = .black
        
        _createEntities()
    }
    
    private func _createEntities() {
        entities.append(CheckerBoard(scene: self, useColorMode: .twoColorSequence, startWithTwoRandomColors: true))
        entities.append(Fireworks(scene: self))
        entities.append(Doggo(scene: self))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    // MARK:- Handling Touches
    private var _touchInUse: UITouch?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if _touchInUse == nil {
            _touchInUse = touches.first
        }
        
        if let touch = _touchInUse {
            for entity in entities.compactMap({ $0 as? SceneTouchAwareEntity }) {
                entity.sceneTouchBegan(touch)
            }
            
            for entity in entities.compactMap({ $0 as? PersonalTouchAwareEntity }) {
                if entity.personalAreaNode.frame.contains(touch.location(in: self)) {
                    entity.personalTouchBegan(touch)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if _touchInUse == nil {
            _touchInUse = touches.sorted { $0.timestamp < $1.timestamp }.first
        }
        
        if let touch = _touchInUse {
            for entity in entities.compactMap({ $0 as? SceneTouchAwareEntity }) {
                entity.sceneTouchMoved(touch)
            }
            
            for var entity in entities.compactMap({ $0 as? PersonalTouchAwareEntity }) {
                if entity.personalAreaNode.frame.contains(touch.location(in: self)) {
                    if entity.touchExitedArea {
                        entity.personalTouchBegan(touch)
                        entity.touchExitedArea = false
                    }
                    else {
                        entity.personalTouchMoved(touch)
                    }
                }
                else {
                    entity.personalTouchEnded(touch)
                    entity.touchExitedArea = true
                }
            }
        }
    }
    
    private func _sharedTouchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = _touchInUse {
            for entity in entities.compactMap({ $0 as? SceneTouchAwareEntity }) {
                entity.sceneTouchEnded(touch)
            }
            
            for entity in entities.compactMap({ $0 as? PersonalTouchAwareEntity }) {
                entity.personalTouchEnded(touch)
            }
            
            for t in touches {
                if t == touch {
                    _touchInUse = nil
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        _sharedTouchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        _sharedTouchesEnded(touches, with: event)
    }
    
    // MARK:- Handling Tap Gesture
    func tapGestureReceived(at point: CGPoint) {
        for entity in entities.compactMap({ $0 as? TapAwareEntity }) {
            entity.onTapReceived(at: point)
        }
    }
}
