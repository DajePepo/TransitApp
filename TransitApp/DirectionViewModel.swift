//
//  DirectionViewModel.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//


public struct DirectionViewModel {
    var name: String?
    var numStops: Int
    var stops: [StopViewModel]
    var travelMode: String?
    var description: String?
    var color: String
    var iconUrl: String
    var polyline: String?
    var startingAddress: String?
    var duration: String?
    var time: String?
    var terminal: String?
    
    init(model: Direction) {
        self.name = model.name
        self.numStops = model.numStops
        self.stops = model.stops.map() { StopViewModel(model: $0) }
        self.travelMode = model.travelMode
        self.description = model.description
        self.color = model.color
        self.iconUrl = model.iconUrl
        self.polyline = model.polyline
        
        if let firstStop = model.stops.first, let lastStop = model.stops.last {
            self.startingAddress = firstStop.name
            self.time = Utils.convertToTime(date: firstStop.time)
            self.duration = Utils.convertToTime(seconds: lastStop.time.timeIntervalSince(firstStop.time))
            self.terminal = lastStop.name
        }
    }
}
