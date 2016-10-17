//
//  Temperature.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/15/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import UIKit

class Temperature: NSObject {
    var averageTemp: Double = 0
    var minTemp: Double = 0
    var maxTemp: Double = 0
    
    override init() {
        super.init()
    }
    
    convenience init(tempDictionary: NSDictionary) {
        self.init()
        averageTemp = tempDictionary["day"] as! Double
        minTemp = tempDictionary["min"] as! Double
        maxTemp = tempDictionary["max"] as! Double
    }

}
