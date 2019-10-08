//
//  HealthSystem.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-12.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import SpriteKit

class HealthSystem {
    /// in percentage
    private var _currentHealth: Float = 100
    private(set) var currentHealth: Float {
        get {
            return _currentHealth
        }
        set {
            _currentHealth = simd_clamp(newValue, _healthRange.min, _healthRange.max)
        }
    }
    
    private var _consumptionLog10Items: Queue<Food> = Queue(capacity: 10)
    var last10FoodsEaten: [Food] {
        return _consumptionLog10Items.storage.compactMap{$0}
    }
    
    private let _healthRange: (min: Float, max: Float)
    
    init(healthRange: (min: Float, max: Float) = (0, 100)) {
        self._healthRange = healthRange
    }
    
    func consume(foodType: Food.FoodType) {
        if let food = FoodBank.shared.get(foodType: foodType) {
            _consumptionLog10Items.enqueue(food)
            _gain(amount: food.energyAmount)
        }
    }
    
    func logHistory() {
        print("=== FOOD CONSUMED HISTORY ===")
        print("Count: \(last10FoodsEaten.count)")
        print(last10FoodsEaten)
    }
    
    private func _gain(amount: Float = 1) {
        currentHealth += amount
    }
    
    public func burnEnergy(amount: Float = 1) {
        currentHealth -= amount
    }
}
