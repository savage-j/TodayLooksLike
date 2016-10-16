//
//  DataSource.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/15/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import UIKit
import Foundation

let forecastNotification = Notification.Name("DidSetNotification")

class DataSource: NSObject {
    
    static let sharedInstance: DataSource = { DataSource() }()

    let weatherClientID = "efd5d81556bf0f4222fb2c18b52ae701"
    var locationCity = ""
    var forecast: Forecast? {
        didSet {
            NotificationCenter.default.post(name: forecastNotification, object: nil)
        }
    }
    
    override init() {
        super.init()
        registerForNotification()
    }
    
    func registerForNotification() {
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: nil) { (note: Notification) in
            self.locationCity = note.object as! String
            self.getWeather(fromCity: self.locationCity)
        }
    }
    
    func getWeather(fromCity city: String){
        let city = city.replacingOccurrences(of: " ", with: "-")
        let urlString = String(format: "http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&units=%@&cnt=1&appid=%@", city, "imperial",weatherClientID)
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil && data != nil else{
                print("error")
                return
            }
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonResult)
                let forecast = Forecast(forecastDictionary: jsonResult as! NSDictionary)
                print(forecast)
                self.forecast = forecast
            } catch {
                print("JSON Serialization failed")
            }
        }
        task.resume()
    }

    
    
}
