//
//  GameViewController.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-08-28.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    private var gameScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameScene = GameScene(fileNamed: "GameScene")
        gameScene.scaleMode = .aspectFill
        
        if let view = self.view as! SKView? {
            view.presentScene(gameScene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapReceived(sender:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func tapReceived(sender: UITapGestureRecognizer) {
        gameScene.tapGestureReceived(at: gameScene.convertPoint(fromView: sender.location(in: view)))
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
