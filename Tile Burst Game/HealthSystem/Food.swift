//
//  Food.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-12.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import Foundation

struct Food {
    enum FoodType {
        case vegetables, chicken, beef, fruits, juice, fries, energyDrink
    }
    
    var foodType: FoodType
    var energyAmount: Float
    var healthy: Bool
}

class FoodBank {
    var shelf: [Food]
    
    static let shared = FoodBank()
    
    private init() {
        self.shelf = [Food(foodType: .vegetables, energyAmount: 70, healthy: true),
                      Food(foodType: .chicken, energyAmount: 85, healthy: true),
                      Food(foodType: .beef, energyAmount: 95, healthy: true),
                      Food(foodType: .fruits, energyAmount: 60, healthy: true),
                      Food(foodType: .juice, energyAmount: 50, healthy: true),
                      Food(foodType: .fries, energyAmount: 40, healthy: false),
                      Food(foodType: .energyDrink, energyAmount: 90, healthy: false)
        ]
    }
    
    func get(foodType: Food.FoodType) -> Food? {
        
        for food in shelf {
            if food.foodType == foodType {
                return food
            }
        }
        
        return nil
    }
}
