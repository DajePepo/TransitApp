//
//  MapViewModel.swift
//  TransitApp
//
//  Created by Pietro Santececca on 22/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel {
    
    
    func centerMapToUserLocation(success: (CLLocationCoordinate2D) -> Void) {
        guard let userLocation = AppDelegate.sharedDelegate().locationManager?.location else {
            return
        }
        success(userLocation.coordinate)
    }
    
}
