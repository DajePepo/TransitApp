//
//  DataManager.swift
//  TransitApp
//
//  Created by Pietro Santececca on 23/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Alamofire
import MapKit

class PlaceDataManager  {
    
    
    static func retreivePlacesFromGoogle(lat: Double, lon: Double, input: String, completion: @escaping ([Place]) -> Void) {
        
        let parameters: [String: String] = [
            "input": input,
            "key": Constants.googleKey,
            "location": "\(lat),\(lon)",
            "radius": Constants.googleSearchRadius
        ]
        
        Alamofire.request(Constants.googleSearchBaseUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Error while fetching google search results: \(response.result.error)")
                return
            }
                
            if let resultResponse = response.result.value as? [String:Any], resultResponse["status"] as? String == "OK" {
                var placeArray = [Place]()
                if let predictions = resultResponse["predictions"] as? [AnyObject] {
                    for (i, prediction) in predictions.enumerated() where i < 3 {
                        if let description = prediction["description"] as? String,
                            let placeId = prediction["place_id"] as? String {
                            let place = Place(id: placeId, description: description)
                            placeArray.append(place)
                        }
                    }
                }
                completion(placeArray)
            }
        }
    }
    
    static func retreivePlaceDetailsFromGoogle(placeId: String, placeDescription: String, completion: @escaping (Place) -> Void) {
        
        var place = Place(id: placeId, description: placeDescription)
        
        let parameters: [String: String] = [
            "placeid": place.id,
            "key": Constants.googleKey,
        ]
        
        Alamofire.request(Constants.googleDetailsBaseUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
            guard response.result.isSuccess else {
                print("Error while fetching google detail result: \(response.result.error)")
                return
            }
            
            if let resultResponse = response.result.value as? [String:Any],
                resultResponse["status"] as? String == "OK",
                let result = resultResponse["result"] as? [String:Any],
                let geometry = result["geometry"] as? [String:Any],
                let location = geometry["location"] as? [String:Any],
                let latitude = location["lat"] as? CLLocationDegrees,
                let longitude = location["lng"] as? CLLocationDegrees
                {
                
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                place.coordinate = coordinate
                completion(place)
            }
        }
    }

    
}
