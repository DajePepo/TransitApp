//
//  Direction.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

public struct Direction {
    var name: String?
    var numStops: Int
    var stops: [Stop]
    var travelMode: String
    var description: String?
    var color: String
    var iconUrl: String
    var polyline: String?
}
