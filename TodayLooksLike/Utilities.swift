//
//  Utilities.swift
//  TodayLooksLike
//
//  Created by Jordan Carlson on 10/16/16.
//  Copyright © 2016 savagej. All rights reserved.
//

import Foundation

class Utilities {
    
    func convert(hPaValue value: Double) -> Double {
        return value/33.86
    }
    
    func convert(precipValue value: Double) -> Double {
        return value/100
    }
    
}

extension String {
    var first: String {
        return String(characters.prefix(1))
    }
    var uppercaseFirst: String {
        return String(first.uppercased()) + String(characters.dropFirst())
    }
}
