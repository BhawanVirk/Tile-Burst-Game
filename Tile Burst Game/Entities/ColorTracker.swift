//
//  ColorTracker.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-10-04.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import SpriteKit
import GameplayKit

class ColorTracker: GKEntity {
    private(set) weak var scene: SKScene?
    private var targetColorNode: UIColor
    
    init(trackColoredNode: UIColor, scene: SKScene) {
        self.scene = scene
        self.targetColorNode = trackColoredNode
        
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
