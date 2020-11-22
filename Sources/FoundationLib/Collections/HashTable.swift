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
        print(items[0].count )
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

public class LinearProbingHashTable<Key: Hashable, Value> {
    
    private let initCapacity = 4
    
    public fileprivate(set) var count: Int = 0
    
    private var items: [(Key, Value)?]
    
    public init() {
        self.count = 0
        self.items = Array(repeating: nil, count: initCapacity)
    }
    
    private func resize(_ size: Int) {
        count = 0
        let oldItems = items
        items = Array(repeating: nil, count: size)
        for item in oldItems {
            if item != nil {
                put(item!.0, item!.1)
            }
        }
    }
    
    private func hash(_ key: Key) -> Int {
        return key.hashValue & (items.count - 1)
    }
    
    public func put(_ key: Key, _ value: Value) {
        if count * 2 >= items.count {
            resize(2 * items.count)
        }
        var i = hash(key)
        while true {
            if items[i] == nil {
                count += 1
                items[i] = (key, value)
                break
            }
            if items[i]?.0 == key {
                items[i]?.1 = value
                break
            }
            i = (i + 1) & (items.count - 1)
        }
    }
    
    public func get(_ key: Key) -> Value? {
        var i = hash(key)
        while true {
            switch items[i] {
            case .none:
                return nil
            case .some(let item):
                if item.0 == key {
                    return item.1
                } else {
                    i = (i + 1) & (items.count - 1)
                }
            }
        }
    }
    
    public func contains(_ key: Key) -> Bool {
        get(key) != nil
    }
    
    public func delete(_ key: Key)  {
        if !contains(key) { return }
        var i = hash(key)
        while key != items[i]?.0 {
            i = (i + 1) & (items.count - 1)
        }
        items[i] = nil
        i = (i + 1) & (items.count - 1)
        while items[i] != nil {
            let newItem = items[i]!
            items[i] = nil
            count -= 1
            put(newItem.0, newItem.1)
            i = (i + 1) & (items.count - 1)
        }
        count -= 1
        if items.count > initCapacity && count <= items.count / 8 {
            resize(items.count >> 1)
        }
    }
    
}
