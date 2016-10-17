//
//  UtilitiesTests.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/16/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import XCTest
@testable import TodayLooksLike

class UtilitiesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testThatConvertingPrecipitationWorks() {
        let precipValue = 8.390000000000001
        let testValue = Utilities().convert(precipValue: precipValue)
        let value = precipValue/100
        XCTAssertEqual(testValue, value)
    }
    
    func testThatConvertingPressureWorks() {
        let pressureValue = 1017.54
        let value = pressureValue/33.86
        let testPressureValue = Utilities().convert(hPaValue: pressureValue)
        XCTAssertEqual(testPressureValue, value)
    }
    
    func testThatStingCapitalizationWorks() {
        var myString = "hello world!"
        myString = myString.uppercaseFirst
        XCTAssertEqual(myString, "Hello world!")
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
