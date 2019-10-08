//
//  Helpers.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-04.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import CoreGraphics
import SpriteKit
import GameplayKit

extension CGPoint {
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

extension CGSize {
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func * (lhs: CGSize, by: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * by, height: lhs.height * by)
    }
}


extension SKNode {
    var currentWidth : CGFloat {
        return calculateAccumulatedFrame().size.width
    }
    
    var currentHeight: CGFloat {
        return calculateAccumulatedFrame().size.height
    }
    
    // MARK:- Position Finding Methods
    func righX(with padding: CGFloat) -> CGFloat {
        return position.x + (calculateAccumulatedFrame().size.width/2) + padding
    }
    
    func leftX(with padding: CGFloat) -> CGFloat {
        return position.x - (calculateAccumulatedFrame().size.width/2) - padding
    }
    
    func topY(with padding: CGFloat) -> CGFloat {
        return position.y + (calculateAccumulatedFrame().size.height/2) + padding
    }
    
    func bottomY(with padding: CGFloat) -> CGFloat {
        return position.y - (calculateAccumulatedFrame().size.height/2) - padding
    }
    
    func screenLeftX(with padding: CGFloat) -> CGFloat {
        return -getScreenSize().width/2 + currentWidth/2 + padding
    }
    
    func screenRightX(with padding: CGFloat) -> CGFloat {
        return getScreenSize().width/2 - currentWidth/2 - padding
    }
    
    func screenTopY(with padding: CGFloat) -> CGFloat {
        return getScreenSize().height/2 - currentHeight/2 - padding
    }
    
    func screenBottomY(with padding: CGFloat) -> CGFloat {
        return -getScreenSize().height/2 + currentHeight/2 + padding
    }
}

func getScreenSize() -> CGSize {
    return UIScreen.main.bounds.size * UIScreen.main.scale
}
