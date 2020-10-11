//
//  BinaryTree.swift
//  
//
//  Created by lonnie on 2020/10/12.
//

import Foundation

public class BinaryTree<T> {
    
     public var value: T
    
     public var left: BinaryTree?
    
     public var right: BinaryTree?
    
     public init(_ value: T) {
         self.value = value
         self.left = nil
         self.right = nil
     }
    
}

public extension BinaryTree {
    
    enum TraverseType {
        
        case preorder
        
        case middleorder
        
        case postorder
    }
    
    func traverse(_ type: TraverseType, _ block: @escaping (T) -> Void) {
        switch type {
        case .preorder:
            preOrder(block)
        case .middleorder:
            middleOrder(block)
        case .postorder:
            postOrder(block)
        }
    }
    
    func preOrder(_ block: @escaping (T) -> Void) {
        block(value)
        left?.preOrder(block)
        right?.preOrder(block)
    }
    
    func middleOrder(_ block: @escaping (T) -> Void) {
        left?.middleOrder(block)
        block(value)
        right?.middleOrder(block)
    }
    
    func postOrder(_ block: @escaping (T) -> Void) {
        left?.postOrder(block)
        right?.postOrder(block)
        block(value)
    }
    
    func invert() {
        swap(&left, &right)
        left?.invert()
        right?.invert()
    }
    
}
