//
//  Temperature.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/15/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import UIKit

class Temperature: NSObject {
    var averageTemp: Double?
    var eveTemp: Double?
    var nightTemp: Double?
    var mornTemp: Double?
    var minTemp: Double?
    var maxTemp: Double?
    
    override init() {
        super.init()
    }
    
    convenience init(tempDictionary: NSDictionary) {
        self.init()
        averageTemp = tempDictionary["day"] as? Double
        eveTemp = tempDictionary["eve"] as? Double
        nightTemp = tempDictionary["night"] as? Double
        mornTemp = tempDictionary["morn"] as? Double
        minTemp = tempDictionary["min"] as? Double
        maxTemp = tempDictionary["max"] as? Double
    }

}
