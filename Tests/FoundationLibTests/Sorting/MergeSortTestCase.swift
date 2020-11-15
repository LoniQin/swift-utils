
//
//  MergeSortTestCase.swift
//
//
//  Created by lonnie on 2020/11/16.
//

import Foundation
import XCTest
@testable import FoundationLib

final class MergeSortTestCase: XCTestCase {
    func testSample() {
        var items = Array(0..<100)
        items.shuffle()
        let merge = MergeSort<Int>()
        merge.sort(&items, <)
        items.assert.equal(Array(0..<100))
    }
}
