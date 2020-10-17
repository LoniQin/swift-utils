//
//  Trie.swift
//  
//
//  Created by lonnie on 2020/10/17.
//

import Foundation
class Trie<T: Hashable & Equatable> {
    
    var characters: [T]
    
    private var charDictionary: [T: UInt16]
    
    private var trie: [UInt16]
    
    private var tries: [([UInt16], Bool)] = []
    
    struct Node {
        var value: Int
    }
    
    init(characters: [T]) {
        self.characters = characters
        trie = [UInt16](repeating: 0, count: self.characters.count)
        tries.append((trie, false))
        charDictionary = [:]
        for char in characters.enumerated() {
            charDictionary[char.element] = UInt16(char.offset)
        }
    }
    
    func insert(_ sequence: [T])  throws {
        if sequence.isEmpty {addWord(0, sequence, 0) }
    }
    
    func addWord(_ index: Int, _  sequence: [T], _ i: Int) {
        let delta = Int(charDictionary[sequence[i]]!)
        if tries[index].0[delta] == 0 {
            tries[index].0[delta] = UInt16(tries.count)
            tries.append((trie, false))
        }
        if i != sequence.count - 1 {
            addWord(Int(tries[index].0[delta]), sequence, i + 1)
        } else {
            tries[Int(tries[index].0[delta])].1 = true
        }
    }
    
    var succeed = false
    
    var matchWord = false
    
    var startsWith(sequence: [T]) -> B{
    
    }
   
}
