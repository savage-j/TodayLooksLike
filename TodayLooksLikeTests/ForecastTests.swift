//
//  ForecastTests.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/16/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import XCTest
@testable import TodayLooksLike

class ForecastTests: XCTestCase {
    
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

        let city: NSDictionary = ["name": "Beaverton"]
        let temp: NSDictionary = ["day": 53.01, "min": 50.58, "max": 53.91]
        let weatherInfo: NSDictionary = ["main": "Rain", "description": "moderate rain", "icon": "10d"]
        let weatherArray: NSArray = [weatherInfo]
        let measure: NSDictionary = ["pressure": 992.66, "humidity": 96, "speed": 14.61, "rain": 8.76, "temp": temp, "weather": weatherArray]
        let list: NSArray = [measure]
        let forecastDictionary: NSDictionary = ["city": city, "list": list]

        let testForecast = Forecast(forecastDictionary: forecastDictionary)
        XCTAssertEqual(testForecast.city! as String, city["name"] as? String, "should be equal")
        XCTAssertEqual(testForecast.mainDescription! as String, weatherInfo["main"] as? String)
        XCTAssertEqual(testForecast.desc! as String, weatherInfo["description"] as? String)
        XCTAssertEqual(testForecast.icon! as String, weatherInfo["icon"] as? String)
        XCTAssertEqual(testForecast.pressure! as Double, measure["pressure"] as? Double)
        XCTAssertEqual(testForecast.humidity! as Int, measure["humidity"] as? Int)
        XCTAssertEqual(testForecast.windSpeed! as Double, measure["speed"] as? Double)
        XCTAssertEqual(testForecast.precipitation! as Double, measure["rain"] as? Double)

        
    }
    
}
