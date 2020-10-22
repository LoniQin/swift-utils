
//
//  CharacterTestCase.swift
//
//
//  Created by lonnie on 2020/10/17.
//

import Foundation
import XCTest
@testable import FoundationLib

final class CharacterTestCase: XCTestCase {
    func testSample() {
        [Character].numbers.assert.equal(Array("0123456789"))
        [Character].lowercasedAlphabets.assert.equal(Array("abcdefghijklmnopqrstuvwxyz"))
    }
}
