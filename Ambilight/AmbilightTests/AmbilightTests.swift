//
//  AmbilightTests.swift
//  AmbilightTests
//
//  Created by Jan de Boer on 08.03.22.
//

import XCTest
@testable import Ambilight

class AmbilightTests: XCTestCase {
    
    let x: Double = 3

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            let splitter = GridSplitter()
            splitter.getRect(fromCoord: Coord(x: 0, y: 0), width: 10, height: 10, cutoffs: Cutoffs(xMin: 20, xMax: 100, yMin: 0, yMax: 10000))
        }
    }

}
