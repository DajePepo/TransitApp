//
//  SearchDirectionsViewModel.swift
//  TransitApp
//
//  Created by Pietro Santececca on 26/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import MapKit

struct SearchDirectionInputViewModel {
    
    var originAddress: String?
    var originLocation: CLLocationCoordinate2D?
    var arrivalAddress: String?
    var arrivalLocation: CLLocationCoordinate2D?
    var timeType: TimeType?
    var time: Date?
    
    init() {}
    
    init(originAddress: String?,
         originLocation: CLLocationCoordinate2D?,
         arrivalAddress: String?,
         arrivalLocation: CLLocationCoordinate2D?,
         timeType: TimeType?,
         time: Date?) {
        
        self.originAddress = originAddress
        self.originLocation = originLocation
        self.arrivalAddress = arrivalAddress
        self.arrivalLocation = arrivalLocation
        self.timeType = timeType
        self.time = time
    }
    
    func getTimeAsString() -> String {
        if let type = self.timeType, let time = self.time {
            return "\(type.rawValue) - \(Utils.convertToString(date: time))"
        }
        else {
            return "Now"
        }
    
    }
}

