//
//  Queue.swift
//  New Game
//
//  Created by Bhawan Virk on 2019-09-12.
//  Copyright © 2019 Virk's Lab. All rights reserved.
//

import Foundation

struct Queue<T> {
    
    private(set) var storage: [T?]
    
    init(capacity: Int) {
        self.storage = Array(repeating: nil, count: capacity)
    }
    
    init(itemsList: [T?]) {
        self.storage = itemsList
    }
    
    mutating func enqueue(_ item: T) {
        // remove the first item
        _ = dequeue()
        
        // append new item at back
        storage.append(item)
    }
        
    /// removes first item and returns it
    mutating func dequeue() -> T? {
        // remove the first item
        return storage.removeFirst()
    }
    
    func lastItem() -> T? {
        return storage[storage.count - 1]
    }
}
