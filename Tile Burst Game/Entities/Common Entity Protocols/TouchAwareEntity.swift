//
//  TouchAwareEntity.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-04.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import UIKit
import SpriteKit

protocol SceneTouchAwareEntity {
    func sceneTouchBegan(_ touch: UITouch)
    func sceneTouchMoved(_ touch: UITouch)
    func sceneTouchEnded(_ touch: UITouch)
}

protocol PersonalTouchAwareEntity {
    var touchExitedArea: Bool { get set }
    var personalAreaNode: SKShapeNode { get set }
    func personalTouchBegan(_ touch: UITouch)
    func personalTouchMoved(_ touch: UITouch)
    func personalTouchEnded(_ touch: UITouch)
}
