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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Start up location manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        registerForNotification()
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
                self.cityLabel.text = forecast.city!
            }
            if forecast.mainDescription != nil {
                self.mainDescLabel.text = forecast.mainDescription!
            }
            if forecast.humidity != nil {
                self.humidityLabel.text = String(describing: forecast.humidity!)
            }
            if forecast.pressure != nil {
                self.pressureLabel.text = String(describing: forecast.pressure!)
            }
            if forecast.precipitation != nil {
                self.precipLabel.text = String(describing: forecast.precipitation!)
            }
            if forecast.windSpeed != nil {
                self.windLabel.text = String(describing: forecast.windSpeed!)
            }
        })
    }
    
    //MARK: Notification Registration
    func registerForNotification() {
        NotificationCenter.default.addObserver(forName: forecastNotification, object: nil, queue: nil) { (note: Notification) in
            print("did receive forecast notification")
            self.updateLabels()
        }
    }
    

}

