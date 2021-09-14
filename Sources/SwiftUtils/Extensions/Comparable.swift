//
//  Comparable.swift
//  
//
//  Created by lonnie on 2020/10/14.
//

import Foundation

public extension Comparable {
    
    func compareTo(_ rhs: Self) -> Int {
        if self < rhs { return -1 }
        if self > rhs { return 1 }
        return 0
    }
    
}
