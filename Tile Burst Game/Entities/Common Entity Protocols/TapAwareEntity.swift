//
//  Tappable.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-03.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//
import CoreGraphics
protocol TapAwareEntity {
    func onTapReceived(at point: CGPoint)
}
