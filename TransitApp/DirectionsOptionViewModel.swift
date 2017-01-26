//
//  DirectionsOptionViewModel.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

public struct DirectionsOptionViewModel {
    
    var mode: String
    var directions: [DirectionViewModel]
    var price: String?
    var duration: String?
    var startingTime: String?
    var arrivalTime: String?
    var startingAddress: String?
    var arrivalAddress: String?
    
    init(model: DirectionsOption) {
        
        self.mode = model.mode
        self.directions = model.directions.map() { DirectionViewModel(model: $0) }
        
        if let price = model.price {
            self.price = "\(price.amount) \(price.currency)"
        }
        
        // Duration
        if let startingDate = model.directions.first?.stops.first?.time,
            let arrivalDate = model.directions.last?.stops.last?.time {
            let durationInSeconds = Int(arrivalDate.timeIntervalSince(startingDate))
            self.duration = Utils.convertToTime(seconds: durationInSeconds)
        }
        
        // Starting and arrival time
        self.startingTime = directions.first?.stops.first?.time
        self.arrivalTime = directions.last?.stops.last?.time
    }
}
