//
//  MapViewExtension.swift
//  TransitApp
//
//  Created by Pietro Santececca on 25/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import GoogleMaps

extension GMSMapView {
    
    func addOriginMarker(location: CLLocationCoordinate2D) {
        let originMarker = GMSMarker(position: location)
        originMarker.title = "Origin"
        originMarker.icon = UIImage(named: "OriginMarker")
        originMarker.map = self
    }
    
    func addDestinationMarker(location: CLLocationCoordinate2D) {
        let destinationMarker = GMSMarker(position: location)
        destinationMarker.title = "Destination"
        destinationMarker.icon = UIImage(named: "DestinationMarker")
        destinationMarker.map = self
    }
    
    func updateCameraAccordingMarkersLocation(locations: [CLLocationCoordinate2D]) {
        let path = GMSMutablePath()
        for location in locations {
            path.add(location)
        }
        let bounds = GMSCoordinateBounds(path: path)
        self.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 25.0))
    }
    
    func drawPath(directions: [(polyline: String, color: String)]) {
         for direction in directions {
            let path = GMSPath(fromEncodedPath: direction.polyline)
            let segment = GMSPolyline(path: path)
            segment.strokeWidth = 5.0
            segment.strokeColor = UIColor(hexString: direction.color)
            segment.map = self
        }
    }
}
