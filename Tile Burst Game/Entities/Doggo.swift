//
//  Doggo.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-12.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import GameplayKit
import SpriteKit

class Doggo: GKEntity {
    
    private(set) weak var scene: SKScene?
    private var _healthSystem: HealthSystem
    
    init(scene: SKScene) {
        self.scene = scene
        self._healthSystem = HealthSystem()
        
        super.init()

        print(_healthSystem.currentHealth)
        var barkCount = 0
        for _ in 1 ... 100 {
            bark()
            barkCount += 1
        }
        print("energy after barking \(barkCount) times: \(_healthSystem.currentHealth)")
        eat(.beef)
        print(_healthSystem.currentHealth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bark() {
        // burn tiny fraction of energy
        _healthSystem.burnEnergy(amount: 0.05)
    }
    
    func eat(_ foodType: Food.FoodType) {
        _healthSystem.consume(foodType: foodType)
    }
    
    func sleep() {
        
    }
}
