//
//  ArrayExtensionTest.swift
//  Ari
//
//  Created by Hiraku Ohno on 2016/07/26.
//  Copyright © 2016年 Hiraku Ohno. All rights reserved.
//

import XCTest

class ArrayExtensionTest: XCTestCase {

    func testCallLowerBound() {
        let array: [Int] = [1, 2, 2, 2, 2, 3, 3, 4, 4, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 9, 13, 19]

        let a = try! array.lowerBound(3)
        XCTAssertEqual(a, array.index(of:3)!)

        let b = try! array.lowerBound(7)
        XCTAssertEqual(b, array.index(of:9)!)

        let c = try! array.lowerBound(11)
        XCTAssertEqual(c, array.index(of:13)!)

        let d = try! array.lowerBound(13)
        XCTAssertEqual(d, array.index(of:13)!)

        let e = try! array.lowerBound(19)
        XCTAssertEqual(e, array.index(of:19)!)

        do {
            let f = try array.lowerBound(20)
        } catch let e as ArrayExtensionError {
            XCTAssertEqual(e, ArrayExtensionError.invalidTarget)
        } catch {
            
        }

        print(try! array.binarySearch(4))

        let g = try! array.lowerBound(4)
        XCTAssertEqual(g, array.index(of:3)! + 2)
    }

    func testLowerBound1() {
        let values = [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5]
        var target = try! values.lowerBound(0)
        XCTAssert(target == 0)

        target = try! values.lowerBound(1)
        XCTAssert(target == 4)

        target = try! values.lowerBound(2)
        XCTAssert(target == 8)

        target = try! values.lowerBound(3)
        XCTAssert(target == 12)

        target = try! values.lowerBound(4)
        XCTAssert(target == 16)

        target = try! values.lowerBound(5)
        XCTAssert(target == 20)
    }

    func testLowerBound2() {
        let values = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2]

        var target = try! values.lowerBound(0)
        XCTAssert(target == 0)

        target = try! values.lowerBound(1)
        XCTAssert(target == 5)

        target = try! values.lowerBound(2)
        XCTAssert(target == 15)
    }

    func testBinarySearch() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertTrue(try array.binarySearch(1) == 0)
        XCTAssertTrue(try array.binarySearch(2) == 1)
        XCTAssertTrue(try array.binarySearch(3) == 2)
        XCTAssertTrue(try array.binarySearch(4) == 3)
        XCTAssertTrue(try array.binarySearch(5) == 4)

        var caught = false
        do {
            try array.binarySearch(0.1)
        } catch ArrayExtensionError.generics {
            caught = true
        } catch {
            
        }
        XCTAssertTrue(caught)

        let bigArray: [UInt64] = {
            var array = [UInt64]()
            (0 ... 10000000).forEach {
                array.append($0 + $0 % 3)
            }
            return array
        }()

        let starta = NSDate()
        (0 ... 20).forEach { _ in
            let index = bigArray.index(of:UInt64(arc4random_uniform(10000000 - 1)))
        }
        let enda = NSDate()

        let diff1 = enda.timeIntervalSince1970 - starta.timeIntervalSince1970

        let startb = NSDate()
        (0 ... 20).forEach { _ in
            let index = try! bigArray.binarySearch(UInt64(arc4random_uniform(10000000 - 1)))
        }
        let endb = NSDate()

        let diff2 = endb.timeIntervalSince1970 - startb.timeIntervalSince1970

        print(diff1)
        print(diff2)
        XCTAssert(diff2 < diff1)
    }

    func testBinarySearchWithNotIncludedValue() {
        let array: [Int] = [1, 2, 3, 5, 6, 9, 10, 11, 14, 19]
        let a = try! array.binarySearch(4)
        let b = try! array.binarySearch(7)
        let c = try! array.binarySearch(8)
        print(index)
    }

    func testLowerBoundTime() {

        let converter: (UInt64) -> [UInt64] = { [$0 * 4, $0 * 4, $0 * 4, $0 * 4] }
        let arrayArray = (UInt64(1) ... UInt64(2_500_000)).map(converter) as [[UInt64]]
        let array = arrayArray.flatMap{ $0 } as [UInt64]
        var target = UInt64(1000000)

        let starta = NSDate()
        let count = 10
        (0 ... count).forEach { i in
            let a = try! array.lowerBound(target)
            let value = array[a]
        }
        let enda = NSDate()

        let startb = NSDate()
        (0 ... count).forEach { i in
            for b in array {
                if target <= b {
                    break
                }
            }
        }
        let endb = NSDate()

        let diff1 = enda.timeIntervalSince1970 - starta.timeIntervalSince1970
        let diff2 = endb.timeIntervalSince1970 - startb.timeIntervalSince1970

        print(diff1)
        print(diff2)

        XCTAssert(diff1 < diff2)
    }
}
