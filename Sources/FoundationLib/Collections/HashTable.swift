//
//  HashTable.swift
//  
//
//  Created by lonnie on 2020/11/22.
//

import Foundation
public class SeparateChainingHashTable<Key: Hashable, Value> {
    
    private let initCapacity = 4
    
    public var capacity: Int
    
    public fileprivate(set) var count: Int
    
    private var items: [[(Key, Value)]]
    
    public init() {
        self.capacity = initCapacity
        items = Array(repeating: [], count: capacity)
        self.count = 0
    }
    
    private func resize(_ size: Int) {
        let oldItems = items
        items = [[(Key, Value)]](repeating: [], count: size)
        for item in oldItems {
            for element in item {
                put(element.0, element.1)
            }
        }
    }
    
    private func hash(_ key: Key) -> Int {
        return key.hashValue & (items.count - 1)
    }
    
    public func put(_ key: Key, _ value: Value) {
        if count >= 10 * items.count {
            resize(2 * items.count)
        }
        let i = hash(key)
        if let index = items[i].firstIndex(where: {$0.0 == key}) {
            items[i][index].1 = value
        } else {
            items[i].append((key, value))
            count += 1
        }
    }
    
    public func get(_ key: Key) -> Value? {
        return items[hash(key)].first { $0.0 == key }?.1
    }
    
    public func contains(_ key: Key) -> Bool {
        get(key) != nil
    }
    
    public func delete(_ key: Key)  {
        let i = hash(key)
        let index = items[i].firstIndex {
            $0.0 == key
        }
        if let index = index {
            if items[i].safelyDelete(at: index) {
                count -= 1
            }
        }
        if items.count > initCapacity && count <= 2 * items.count {
            resize(count >> 1)
        }
    }
    
}
