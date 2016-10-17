//
//  TemperatureTests.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/16/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import XCTest
@testable import TodayLooksLike

class TemperatureTests: XCTestCase {
    
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testThatInitializationWorks() {
        let temperatureDictionary: NSDictionary = ["day": 53.01, "min": 50.58, "max": 53.91]
        let testTemperature = Temperature(tempDictionary: temperatureDictionary)
        XCTAssertEqual(testTemperature.averageTemp, temperatureDictionary["day"] as! Double, "The day temperatures should be equal")
        XCTAssertEqual(testTemperature.minTemp, temperatureDictionary["min"] as! Double, "The minimum temperatures should be equal")
        XCTAssertEqual(testTemperature.maxTemp, temperatureDictionary["max"] as! Double, "The maximum temperatures should be equal")

        
    }
    
}
