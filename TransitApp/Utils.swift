//
//  Utils.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

struct Utils {
    
    static func convertToTime(seconds: Double) -> String {
        return convertToTime(seconds: Int(seconds))
    }
    
    static func convertToTime(seconds: Int) -> String {
        
        let hour = seconds / 3600
        let minute = (seconds % 3600) / 60
        
        var time = ""
        if hour > 0 {
            time += "\(hour) h "
        }
        if minute > 0 {
            time += "\(minute) min"
        }
        return time
    }
    
    static func convertToTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func convertToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM, HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func convertToDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddEEEEHH:mm:ssZZZ"
        return dateFormatter.date(from: string)
    }
    
}
