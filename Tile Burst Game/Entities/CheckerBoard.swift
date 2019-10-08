//
//  CheckerBoard.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-05.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import GameplayKit
import SpriteKit

class CheckerBoard: GKEntity {
    
    enum ColorMode {
        case twoColorSequence, random
    }
    
    private(set) weak var scene: SKScene!
    var parentNode: SKNode
    var checkerSize: CGSize = CGSize(width: 30, height: 30)
    var horizontalAmount: Int = 21
    var verticalAmount: Int = 21
    var colorMode: ColorMode
    var twoColors: [UIColor] = [.brown, .magenta]
    var startWithTwoRandomColors: Bool
    private var _randomColorsList: [UIColor] = [.red, .green, .blue, .yellow, .orange, .cyan, .purple, .magenta, .brown]
    private var _lastColorFirst = false
    private var _boardSize: CGSize = .zero
    
    init(scene: SKScene, useColorMode: ColorMode = .twoColorSequence, startWithTwoRandomColors: Bool = false, position: CGPoint = CGPoint(x: -300, y: -300), zPos: CGFloat = 1) {

        self.scene = scene
        self.parentNode = SKNode()
        self.parentNode.position = position
        self.parentNode.zPosition = zPos
        self.colorMode = useColorMode
        self.startWithTwoRandomColors = startWithTwoRandomColors
        
        super.init()
        
        self.scene.addChild(parentNode)
        
        generateNewBoard()
        _setupHUD()
        
        let bottomFloor = SKShapeNode(rectOf: CGSize(width: checkerSize.width * CGFloat(horizontalAmount * 5), height: 25))
        bottomFloor.position = CGPoint(x: 0, y: bottomFloor.screenBottomY(with: 100))
        bottomFloor.fillColor = .clear
        bottomFloor.lineWidth = 0
        bottomFloor.physicsBody = SKPhysicsBody(rectangleOf: bottomFloor.calculateAccumulatedFrame().size)
        bottomFloor.physicsBody?.isDynamic = false
        scene.addChild(bottomFloor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateNewBoard() {
        
        parentNode.children.forEach { (node) in
            node.removeAllActions()
            node.userData = nil
            node.removeFromParent()
        }
        
        if startWithTwoRandomColors {
            var colorPallette = Array(_randomColorsList)
            twoColors = [colorPallette.remove(at: Int.random(in: 0 ... colorPallette.count-1)), colorPallette.remove(at: Int.random(in: 0 ... colorPallette.count-1))]
        }
        
        // draw board
        for x in 0 ..< horizontalAmount {
            for y in 0 ..< verticalAmount {
                let checker = SKShapeNode(rectOf: checkerSize)
                let checkerPos = CGPoint(x: checkerSize.width * CGFloat(x), y: checkerSize.height * CGFloat(y))
                checker.position = checkerPos
                checker.userData = ["positionInBoard": checkerPos, "invisible": false]
                checker.fillColor = _newCheckerColor()
                checker.alpha = 0
                checker.setScale(CGFloat.random(in: 1.5 ... 2.5))
                checker.lineWidth = 0
                parentNode.addChild(checker)
                
                checker.run(SKAction.fadeIn(withDuration: Double.random(in: 0.5 ... 2)), withKey: "startupFadeIn")
                checker.run(SKAction.scale(to: 1, duration: 0.75))
                
                // toggle it's value
                _lastColorFirst = !_lastColorFirst
            }
        }
        
        _boardSize = CGSize(width: checkerSize.width * CGFloat(horizontalAmount), height: checkerSize.height * CGFloat(verticalAmount))
    }
    
    private func _newCheckerColor() -> UIColor {
        if colorMode == .twoColorSequence {
            return _lastColorFirst ? twoColors[1] : twoColors[0]
        }
        
        return _randomColorsList.randomElement()!
    }
    
    private func _setupHUD() {
        // (1) Generate Board Button
        let generateNewBoardButton = ButtonNode(label: "Generate New Board") { [weak self] in
            self?.generateNewBoard()
        }
        generateNewBoardButton.position = CGPoint(x: generateNewBoardButton.screenLeftX(with: 25), y: generateNewBoardButton.screenTopY(with: 25))
        scene.addChild(generateNewBoardButton)
        
        // (2) Reset Board Button
        let resetBoardButton = ButtonNode(label: "Refill Board") { [weak self] in
            self?.refill()
        }
        resetBoardButton.position = CGPoint(x: resetBoardButton.screenRightX(with: 25), y: resetBoardButton.screenTopY(with: 25))
        scene.addChild(resetBoardButton)
        
        // (3) Add Physics Button
        let checkerAddPhysicsButton = ButtonNode(label: "Let Em Fall") { [weak self] in
            self?.addPhysics()
        }
        checkerAddPhysicsButton.position = CGPoint(x: checkerAddPhysicsButton.screenLeftX(with: 25), y: checkerAddPhysicsButton.screenBottomY(with: 25))
        scene.addChild(checkerAddPhysicsButton)
        
        // (4) Reset Physics Behaviour Button
        let restackButton = ButtonNode(label: "Bring Em Back") { [weak self] in
            self?.restack()
        }
        //checkerAddPhysicsButton.righX(with: 50) + restackButton.currentWidth/2
        restackButton.position = CGPoint(x: restackButton.screenRightX(with: 25), y: restackButton.screenBottomY(with: 25))
        scene.addChild(restackButton)
    }
    
    func addPhysics() {
        for checker in parentNode.children {
            if checker.physicsBody == nil, checker.userData?["invisible"] as? Bool == false {
                checker.physicsBody = SKPhysicsBody(rectangleOf: checker.calculateAccumulatedFrame().size)
            }
        }
    }
    
    func restack() {
        for checker in parentNode.children {
            if let checkerPosInBoard = checker.userData?["positionInBoard"] as? CGPoint, checker.position != checkerPosInBoard {
                checker.physicsBody = nil
                checker.run(SKAction.group([SKAction.move(to: checkerPosInBoard, duration: 0.5), SKAction.rotate(toAngle: 0, duration: 0.5)]))
            }
        }
    }
    
    func refill() {
        restack()
        for checker in parentNode.children {
            checker.userData?["invisible"] = false
            checker.run(SKAction.fadeIn(withDuration: 0.5))
        }
    }
}

extension CheckerBoard : SceneTouchAwareEntity {
    
    func sceneTouchBegan(_ touch: UITouch) {
        
    }
    
    func sceneTouchMoved(_ touch: UITouch) {
        for n in parentNode.nodes(at: touch.location(in: parentNode)) {
            n.userData?["invisible"] = true
            n.removeAction(forKey: "startupFadeIn")
            n.run(SKAction.fadeOut(withDuration: 0.1))
            n.physicsBody = nil
        }
    }
    
    func sceneTouchEnded(_ touch: UITouch) {
        
    }
}
