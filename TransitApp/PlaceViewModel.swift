//
//  PlaceViewModel.swift
//  TransitApp
//
//  Created by Pietro Santececca on 23/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import MapKit

public struct PlaceViewModel {
    var id: String
    var coordinate: CLLocationCoordinate2D?
    var description: String
    
    init(id: String, description: String) {
        self.id = id
        self.description = description
    }
    
    init(model: Place) {
        self.id = model.id
        self.description = model.description
        self.coordinate = model.coordinate
    }
}
