//
//  StopViewModel.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import MapKit

public struct StopViewModel {
    
    var name: String?
    var time: String
    var coordinate: CLLocationCoordinate2D
    var color: String?
    
    init(model: Stop) {
        self.name = model.name
        self.time = Utils.convertToTime(date: model.time)
        self.coordinate = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        self.color = model.color
    }
}
