//
//  BinaryTreeProtocol.swift
//  
//
//  Created by lonnie on 2020/10/12.
//

import Foundation
public enum TraverseType {
    
    case preorder
    
    case middleorder
    
    case postorder
}

public protocol BinaryTreeProtocol: class {
    
    associatedtype T
    
    var value: T { get }
    
    var left: Self? { get set }
    
    var right: Self? { get set }
    
}

public extension BinaryTreeProtocol {
    
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
    
    func array(_ type: TraverseType) -> [T] {
        var items = [T]()
        traverse(type, {
            items.append($0)
        })
        return items
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
    
    func numberOfLevels() -> Int {
        numberOfLevels(self)
    }
    
}

extension BinaryTreeProtocol {
    func numberOfLevels(_ node: Self?) -> Int {
        node == nil ? 0 : 1 + max(numberOfLevels(node?.left), numberOfLevels(node?.right))
    }
}
