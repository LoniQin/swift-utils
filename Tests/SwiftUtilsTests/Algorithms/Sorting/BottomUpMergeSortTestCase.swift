
//
//  BottomUpMergeSortTestCase.swift
//
//
//  Created by lonnie on 2020/11/16.
//

import Foundation
import XCTest
@testable import SwiftUtils

final class BottomUpMergeSortTestCase: XCTestCase {
    func testBottomUpMergeSort() {
        var items = Array(0..<100)
        items.shuffle()
        let merge = BottomUpMergeSort<Int>()
        merge.sort(&items, <)
        items.assert.equal(Array(0..<100))
    }
}
