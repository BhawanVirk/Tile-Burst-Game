//
//  LinearGradientSampler.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-27.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import SpriteKit

struct LinearGradientSampler {
    private let _colorsSeq: SKKeyframeSequence
    
    init(colors: [UIColor], length: CGFloat) {
        self._colorsSeq = SKKeyframeSequence(capacity: colors.count)
        
        let totalColors = colors.count
        
        if totalColors == 1 {
            _colorsSeq.addKeyframeValue(colors[0], time: length)
        }
        else {
            for i in 0 ..< totalColors {
//                print("time: \((length / CGFloat(totalColors-1)) * CGFloat(i))")
                _colorsSeq.addKeyframeValue(colors[i], time: (length / CGFloat(totalColors-1)) * CGFloat(i))
            }
        }
    }
    
    func sample(at: CGFloat) -> UIColor? {
        return _colorsSeq.sample(atTime: at) as? UIColor
    }
}
