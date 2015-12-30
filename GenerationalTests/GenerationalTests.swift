//
//  GenerationalTests.swift
//  GenerationalTests
//
//  Created by Jaden Geller on 12/28/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

import XCTest
@testable import Generational

class GenerationalTests: XCTestCase {
    
    func testConcatenate() {
        var expect = 0
        for x in (0...3) + (7...10) {
            XCTAssertEqual(expect, x)
            
            expect += 1
            if expect == 4 { expect = 7 }
        }
    }
    
    func testCycle() {
        for (i, x) in (0...3).cycle().enumerate() {
            XCTAssertEqual(i % 4, x)
            if i > 30 { return }
        }
    }
    
    func testRepeat() {
        for (i, x) in RepeatedValueSequence(10).enumerate() {
            XCTAssertEqual(10, x)
            if i > 5 { return }
        }
    }
    
    func testExtend() {
        for (i, x) in (0...4).extend(byRepeatingValue: 0).enumerate() {
            if i <= 4 {
                XCTAssertEqual(i, x)
            } else {
                XCTAssertEqual(0, x)
            }
            if i > 20 { return }
        }
    }
    
    func testFullZip() {
        for (i, (l, r)) in fullZip(0...10, 0...3).enumerate() {
            XCTAssertEqual(i, l)
            XCTAssertEqual(i <= 3 ? i : nil, r)
        }
    }
    
    func testFullZipDefaultValues() {
        for (i, (l, r)) in fullZip(0...3, 0...10, defaultValues: (9, 9)).enumerate() {
            XCTAssertEqual(i, r)
            XCTAssertEqual(i <= 3 ? i : 9, l)
        }
    }
    
    func testDrop() {
        var expected = 5
        for x in (1...10).dropWhile({ $0 < 5 || $0 > 8 }) {
            XCTAssertEqual(expected, x)
            expected += 1
        }
        XCTAssertEqual(expected, 11)
    }
    
    func testTake() {
        var expected = 1
        for x in (1...10).takeWhile({ $0 < 5 || $0 > 8 }) {
            XCTAssertEqual(expected, x)
            expected += 1
        }
        XCTAssertEqual(expected, 5)
    }
    
    func testIterate() {
        var z = 1
        for x in iterate(initialValue: 1, transform: { $0 * 2 }).prefix(5) {
            XCTAssertEqual(z, x)
            z *= 2
        }
        XCTAssertEqual(32, z)
    }
    
    func testPairwiseComparing() {
        for (i, x) in [1, 2, 3].pairwiseComparison().enumerate() {
            switch i {
            case 0:  XCTAssertTrue(PairwiseComparison.Initial(1) == x)
            case 1:  XCTAssertTrue(PairwiseComparison.Pair(1, 2) == x)
            case 2:  XCTAssertTrue(PairwiseComparison.Pair(2, 3) == x)
            case 3:  XCTAssertTrue(PairwiseComparison.Final(3)   == x)
            default: XCTFail()
            }
        }
    }
    
    func testPartitioning() {
        let result = "hello world   how are you?".characters.partition({ ($0 == " ") != ($1 == " ") })
        XCTAssertEqual(["hello", " ", "world", "   ", "how", " ", "are", " ", "you?"], Array(result).map(String.init))
    }
}
