class TestCase:
    def __init__(self):
        self.name = ""
        self.functions = []

template = """
//
//  {name}TestCase.swift
//
//
//  Created by lonnie on {date}.
//

import Foundation
import XCTest
@testable import FoundationLib

final class {name}TestCase: XCTestCase {
    func testSample() {

    }
}
"""
