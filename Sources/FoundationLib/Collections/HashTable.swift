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
    
    private var items: [ListNode<(Key, Value)>?]
    
    public init(capacity: Int = 4) {
        self.capacity = capacity
        items = Array(repeating: nil, count: capacity)
        self.count = 0
    }
    
    private func resize(_ size: Int) {
        let oldItems = items
        items = [ListNode<(Key, Value)>?](repeating: nil, count: capacity)
        for item in oldItems {
            if let item = item {
                for element in item {
                    put(element.0, element.1)
                }
            }
        }
    }
    
    private func hash(_ key: Key) -> Int {
        abs(key.hashValue) % items.count
    }
    
    public func put(_ key: Key, _ value: Value) {
        if count >= 10 * items.count {
            resize(2 * items.count)
        }
        let i = hash(key)
        if let node = items[i] {
            items[i] = ListNode((key, value), node)
        } else {
            items[i] = ListNode((key, value), nil)
        }
    }
    
    public func get(_ key: Key) -> Value? {
        if let node = items[hash(key)] {
            for item in node {
                if item.0 == key {
                    return item.1
                }
            }
        }
        return nil
    }
    
    public func contains(_ key: Key) -> Bool {
        get(key) != nil
    }
    
    public func delete(_ key: Key)  {
        let i = hash(key)
        if items[i] != nil {
            var node = items[i]
            if node?.value.0 == key {
                items[i] = node?.next
            } else {
                while node?.next != nil {
                    if node?.next!.value.0 == key {
                        node?.next = node?.next?.next
                    }
                    node = node?.next
                }
            }
        }
        if items.count > 4 && count <= 2 * items.count {
            resize(count >> 1)
        }
    }
    
    deinit {
        while !items.isEmpty {
            var node = items.popLast()!
            while node != nil {
                node = node?.next
            }
        }
    }
    
}
