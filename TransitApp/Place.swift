//
//  Place.swift
//  TransitApp
//
//  Created by Pietro Santececca on 23/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import MapKit

public struct Place {
    
    var id: String
    var description: String
    var coordinate: CLLocationCoordinate2D?
    
    init(id: String, description: String) {
        self.id = id
        self.description = description
    }
}
