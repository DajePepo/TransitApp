//
//  DirectionsDataManager.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import MapKit

class DirectionsDataManager  {

    static func retreiveDirectionsOptions(originLocation: CLLocationCoordinate2D,
                                   arrivalLocation: CLLocationCoordinate2D,
                                   timeType: TimeType,
                                   time: Date) -> [DirectionsOption] {
        
        guard let result = parseJsonData() else {
            print("Error during JSON parsing: file is badly formatted")
            return []
        }
        return result
    }
    
    static fileprivate func parseJsonData() -> [DirectionsOption]? {
        
        var options = [DirectionsOption]()
        
        guard let url = Bundle.main.url(forResource: "door2door", withExtension: "json") else {
            return nil
        }
        
        do {
        
            let data = try Data(contentsOf: url)
            
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                let optionsJson = json["routes"] as? [[String: Any]] {
                
                for optionJson in optionsJson {
                    
                    // Directions mode
                    guard let mode = optionJson["type"] as? String else { return nil }
                    
                    // Directions provider
                    guard let provider = optionJson["provider"] as? String else { return nil }
                    
                    // Directions list
                    guard let directionsJson = optionJson["segments"] as? [[String: Any]] else { return nil }
                    
                    // Directions price
                    var price: Price?
                    if let priceJson = optionJson["price"] as? [String: Any] {
                        guard let currency = priceJson["currency"] as? String else { return nil }
                        guard let amount = priceJson["amount"] as? Double else { return nil }
                        price = Price(currency: currency, amount: amount)
                    }
                    
                    var directions = [Direction]()
                    for directionJson in directionsJson {
                        
                        // Direction name
                        var name: String?
                        if let nameJson = directionJson["name"] as? String { name = nameJson }
                        
                        // Direction num stops
                        guard let numStops = directionJson["num_stops"] as? Int else { return nil }
                        
                        // Direction travel mode
                        guard let travelMode = directionJson["travel_mode"] as? String else { return nil }
                        
                        // Direction description
                        var description: String?
                        if let descriptionJson = directionJson["description"] as? String { description = descriptionJson }
                        
                        // Direction color
                        guard let color = directionJson["color"] as? String else { return nil }
                        
                        // Direction icon url
                        guard let iconUrl = directionJson["icon_url"] as? String else { return nil }
                        
                        // Direction polyline
                        var polyline: String?
                        if let polylineJson = directionJson["polyline"] as? String { polyline = polylineJson }
                        
                        // Stops
                        guard let stopsJson = directionJson["stops"] as? [[String: Any]] else { return nil }
                        
                        var stops = [Stop]()
                        for stopJson in stopsJson {
                            
                            // Stop latitude
                            guard let latitude = stopJson["lat"] as? Double else { return nil }

                            // Stop longitude
                            guard let longitude = stopJson["lng"] as? Double else { return nil }
                            
                            // Stop time
                            guard let timeString = stopJson["datetime"] as? String,
                                let timeDate = Utils.convertToDate(string: timeString) else { return nil }
                            
                            // Stop name
                            var name: String?
                            if let nameJson = stopJson["name"] as? String { name = nameJson }
                            
                            // Create a new stop
                            let stop = Stop(name: name, latitude: latitude, longitude: longitude, time: timeDate, color: color)
                            
                            // Add stop to the stop list
                            stops.append(stop)
                        }
                        
                        // Create a new direction
                        let direction = Direction(name: name, numStops: numStops, stops: stops, travelMode: travelMode, description: description, color: color, iconUrl: iconUrl, polyline: polyline)
                        
                        // Add direction to the directions list
                        directions.append(direction)
                    }
                    
                    // Create a new option
                    let option = DirectionsOption(mode: mode, provider: provider, price: price, directions: directions)
                    
                    // Add option to the result list
                    options.append(option)
                }
            }
        }
        
        catch {
            print("Error deserializing JSON: \(error)")
        }
        
        return options
    }
}
