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
let imageIconNotification = Notification.Name("DidRetrieveImageIcon")

class DataSource: NSObject {
    
    static let sharedInstance: DataSource = { DataSource() }()

    let weatherClientID = "efd5d81556bf0f4222fb2c18b52ae701"
    var locationCity = ""
    var forecast: Forecast? {
        didSet {
            NotificationCenter.default.post(name: forecastNotification, object: nil)
            self.retrieveIcon(for: self.forecast!)
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
    
    func retrieveIcon(for forecast: Forecast){
        let urlString = String(format: "http://openweathermap.org/img/w/%@.png", forecast.icon!)
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil && data != nil else {
                print("error retrieving icon")
                return
            }
            var documentsDirectory: String?
            var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as [AnyObject]
            if paths.count > 0 {
                documentsDirectory = paths[0] as? String
                let fileExtension = String(format: "/%@.png", forecast.icon!)
                let savePath = documentsDirectory! + fileExtension
                FileManager.default.createFile(atPath: savePath, contents: data, attributes: nil)
                
                DispatchQueue.main.async(execute: {
                    NotificationCenter.default.post(name: imageIconNotification, object: savePath)
                })
            }
        }
        task.resume()
    }

    
    
}
