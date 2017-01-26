//
//  ShowDirectionsViewModelController.swift
//  TransitApp
//
//  Created by Pietro Santececca on 25/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import GoogleMaps

class ShowViewModelController {
    
    fileprivate var directionsOptionViewModel: DirectionsOptionViewModel
    
    init(directionsOption: DirectionsOptionViewModel) {
        self.directionsOptionViewModel = directionsOption
    }
    
    var directionsCount: Int {
        return directionsOptionViewModel.directions.count
    }
    
    func directionViewModel(at index: Int) -> DirectionViewModel {
        var direction = directionsOptionViewModel.directions[index]
        if index == 0 { direction.startingAddress = directionsOptionViewModel.startingAddress }
        return direction
    }
    
    func stopsCount(section: Int) -> Int {
        return directionsOptionViewModel.directions[section].stops.count
    }
    
    func stopViewModel(section: Int, index: Int) -> StopViewModel {
        return directionsOptionViewModel.directions[section].stops[index]
    }
    
    func headerDirectionsViewModel() -> DirectionsOptionViewModel {
        return directionsOptionViewModel
    }
    
    func footerDirectionsViewModel() -> DirectionsOptionViewModel {
        return directionsOptionViewModel
    }
    
    func originPosition() -> CLLocationCoordinate2D? {
        return directionsOptionViewModel.directions.first?.stops.first?.coordinate
    }
    
    func destinationPosition() -> CLLocationCoordinate2D? {
        return directionsOptionViewModel.directions.last?.stops.last?.coordinate
    }
    
    func pathSegments() -> [(polyline: String, color: String)] {
    
        var segments = [(polyline: String, color: String)]()
        for direction in directionsOptionViewModel.directions {
            if let polyline = direction.polyline {
                segments.append((polyline: polyline, color: direction.color))
            }
        }
        return segments
    }
    
}
