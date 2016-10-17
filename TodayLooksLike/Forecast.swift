//
//  Forecast.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/15/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import Foundation

class Forecast: NSObject {
    var city: String?
    var humidity: Int?
    var windSpeed: Double?
    var precipitation: Double?
    var pressure: Double?
    var temps: Temperature
    var desc: String?
    var icon: String?
    var mainDescription: String?
    
    override init(){
        self.temps = Temperature()
        super.init()
    }
    
    convenience init(forecastDictionary: NSDictionary){
        self.init()
        
        if let cityInfo = forecastDictionary["city"] as? NSDictionary {
            city = cityInfo["name"] as? String
        } else {
            city = ""
        }
        
        if let list = forecastDictionary["list"] as? NSArray {
            let measurements = list[0] as! NSDictionary
            windSpeed = measurements["speed"] as? Double
            pressure = measurements["pressure"] as? Double
            precipitation = measurements["rain"] as? Double
            humidity = measurements["humidity"] as? Int
            
            if let tempDictionary = measurements["temp"] as? NSDictionary {
                temps = Temperature(tempDictionary: tempDictionary)
            }
            
            if let weather = measurements["weather"] as? NSArray {
                let weatherInfo = weather[0] as! NSDictionary
                desc = (weatherInfo["description"] as? String)
                icon = (weatherInfo["icon"] as? String)
                mainDescription = (weatherInfo["main"] as? String)
            }
            
        }
    }
    
}
