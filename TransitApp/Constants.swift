//
//  Constants.swift
//  TransitApp
//
//  Created by Pietro Santececca on 22/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import MapKit

struct Constants {

    // Google
    static let googleKey = "AIzaSyAnIGSLWPoRkMBb5t9IR0OKwBfgUJutP98"
    static let googleSearchBaseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
    static let googleDetailsBaseUrl = "https://maps.googleapis.com/maps/api/place/details/json?"
    static let googleSearchRadius = "100000"

    // Map
    static let berlinCenter = CLLocationCoordinate2D(latitude: 52.520703, longitude: 13.411305)
    static let defaultZoomLevel:Double = 13
}
