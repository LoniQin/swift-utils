//
//  BinaryTree.swift
//  
//
//  Created by lonnie on 2020/10/12.
//

import Foundation

public final class BinaryTree<T>: NSObject {
    
     public var value: T
    
     public var left: BinaryTree<T>?
    
     public var right: BinaryTree<T>?
    
     public init(_ value: T) {
         self.value = value
         self.left = nil
         self.right = nil
     }
    
}


extension BinaryTree: BinaryTreeProtocol {
    
}
