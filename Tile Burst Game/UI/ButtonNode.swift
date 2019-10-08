//
//  ButtonNode.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-30.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import SpriteKit

class ButtonNode: SKNode {
    
    var touchInsideCallback: () -> Void
    var labelNode: SKLabelNode!
    var labelBackgroundNode: SKShapeNode!
    var animationDuration: CGFloat
    var labelHighlightSampler: LinearGradientSampler
    var backgroundHighlightSampler: LinearGradientSampler
    var useImpactFeedback = true
    var impactFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle = .light
    
    init(label: String, fontSize: CGFloat = 40, labelColor: UIColor = .black, backgroundColor: UIColor = .lightGray, backgroundPadding: CGSize = CGSize(width: 50, height: 50), cornerRadius: CGFloat = 5, highlightLabelColor: UIColor = .blue, highlightAnimationDuration: CGFloat = 1, onTouchInside: @escaping () -> Void) {
        
        touchInsideCallback = onTouchInside
        animationDuration = highlightAnimationDuration
        labelHighlightSampler = LinearGradientSampler(colors: [labelColor, highlightLabelColor], length: animationDuration)
        backgroundHighlightSampler = LinearGradientSampler(colors: [backgroundColor, .white], length: animationDuration)
        
        super.init()
        
        labelNode = SKLabelNode(text: label)
        labelNode.fontColor = labelColor
        labelNode.fontSize = fontSize
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.zPosition = 1
        
        labelBackgroundNode = SKShapeNode(rectOf: labelNode.calculateAccumulatedFrame().size + backgroundPadding, cornerRadius: cornerRadius)
        labelBackgroundNode.fillColor = backgroundColor
        labelBackgroundNode.lineWidth = 0
        labelBackgroundNode.zPosition = 0
        addChild(labelNode)
        addChild(labelBackgroundNode)
        
        print("button frame: \(calculateAccumulatedFrame())")
    }
    
    convenience init(label: String, labelColor: UIColor, backgroundColor: UIColor = .lightGray, highlightLabelColor: UIColor, onTouchInside: @escaping () -> Void) {
        self.init(label: label, fontSize: 36, labelColor: labelColor, backgroundColor: backgroundColor, backgroundPadding: CGSize(width: 50, height: 25), cornerRadius: 5, highlightLabelColor: highlightLabelColor, highlightAnimationDuration: 0.5, onTouchInside: onTouchInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Selection Animations
    
    private func _doSelectAnimation() {
        // do label highlight animation
        labelNode.run(SKAction.customAction(withDuration: TimeInterval(animationDuration), actionBlock: { [weak self] (node, time) in
            (node as? SKLabelNode)?.fontColor = self?.labelHighlightSampler.sample(at: time)
        }))
        
        labelBackgroundNode.run(SKAction.customAction(withDuration: TimeInterval(animationDuration), actionBlock: { [weak self] (node, time) in
            (node as? SKShapeNode)?.fillColor = self?.backgroundHighlightSampler.sample(at: time) ?? .clear
        }))
    }
    
    private func _doUnselectAnimation() {
        labelNode.run(SKAction.customAction(withDuration: TimeInterval(animationDuration), actionBlock: { [weak self] (node, time) in
            (node as? SKLabelNode)?.fontColor = self?.labelHighlightSampler.sample(at: self!.animationDuration-time)
        }))
        
        labelBackgroundNode.run(SKAction.customAction(withDuration: TimeInterval(animationDuration), actionBlock: { [weak self] (node, time) in
            (node as? SKShapeNode)?.fillColor = self?.backgroundHighlightSampler.sample(at: self!.animationDuration-time) ?? .clear
        }))
    }
    
    // MARK:- Handling User Interaction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // call button handler
        touchInsideCallback()
        // trigger impact feedback
        if useImpactFeedback {
            UIImpactFeedbackGenerator(style: impactFeedbackStyle).impactOccurred()
        }
        // do highlight animation
        _doSelectAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        // do reverse label highlight animation
        _doUnselectAnimation()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        _doUnselectAnimation()
    }
    
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // ignore
        }
    }
}
