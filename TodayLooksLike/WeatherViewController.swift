//
//  ViewController.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/15/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import UIKit
import CoreLocation

let notificationName = Notification.Name("ReceivedUserLocation")

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mainDescLabel: UILabel!
    @IBOutlet weak var forecastTextLabel: UILabel!
    @IBOutlet weak var aveTempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Start up location manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        registerForNotification()
        registerForImageNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            guard error == nil else {
                print("Something went wrong \(error)")
                return
            }
            if let placemark = placemarks?[0] {
                let city = String(format: "%@,%@", placemark.locality!, placemark.isoCountryCode!)
                NotificationCenter.default.post(name: notificationName, object: city)
            }
        }
    }
    
    //MARK: DataSource shared instance
    
    func forecast() -> Forecast {
        return DataSource.sharedInstance.forecast!
    }
    
    //MARK: UI Helper Methods
    func updateLabels() {
        DispatchQueue.main.async(execute: {
            let forecast = self.forecast()
            
            if forecast.city != nil {
                self.cityLabel.adjustsFontSizeToFitWidth = true
                self.cityLabel.text = forecast.city!
            }
            if forecast.mainDescription != nil {
                self.mainDescLabel.adjustsFontSizeToFitWidth = true
                self.mainDescLabel.text = forecast.mainDescription!
            }
            if forecast.humidity != nil {
                //self.humidityLabel.adjustsFontSizeToFitWidth = true
                self.humidityLabel.text = String(format: "%d %%",forecast.humidity!)
            }
            if forecast.pressure != nil {
                //self.pressureLabel.adjustsFontSizeToFitWidth = true
                let pressureConverted = Utilities().convert(hPaValue: forecast.pressure!)
                self.pressureLabel.text = String(format: "%.1f inHg", pressureConverted)
            }
            if forecast.precipitation != nil {
                //self.precipLabel.adjustsFontSizeToFitWidth = true
                let precipConverted = Utilities().convert(precipValue: forecast.precipitation!)
                self.precipLabel.text = String(format: "%.1f in", precipConverted)
            }
            if forecast.windSpeed != nil {
                //self.windLabel.adjustsFontSizeToFitWidth = true
                self.windLabel.text = String(format: "%.0f mph", forecast.windSpeed!)
            }
            
            self.updateForecastText()
        })
    }
    
    func updateForecastText() {
        let forecast = self.forecast()
        let temps = forecast.temps
        let maxTemp = String(format: "%.0f°", temps.maxTemp)
        let minTemp = String(format: "%.0f°", temps.minTemp)
        self.aveTempLabel.text = String(format: "%.0f°", temps.averageTemp)
        let descrip = (forecast.desc!).uppercaseFirst
        self.forecastTextLabel.text = "\(descrip). The high will be \(maxTemp). The low will be \(minTemp)"
    }

    
    //MARK: Notification Registration
    func registerForNotification() {
        NotificationCenter.default.addObserver(forName: forecastNotification, object: nil, queue: nil) { (note: Notification) in
            self.updateLabels()
        }
    }
    
    func registerForImageNotification(){
        NotificationCenter.default.addObserver(forName: imageIconNotification, object: nil, queue: nil) { (note: Notification) in
            let savePath = note.object as! String
            DispatchQueue.main.async(execute: {
                self.weatherIcon.image = UIImage(named: savePath)
            })
        }
    }
    

}

