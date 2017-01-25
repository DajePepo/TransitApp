//
//  DataManager.swift
//  TransitApp
//
//  Created by Pietro Santececca on 23/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Alamofire

class DataManager  {
    
    static func getGooglePlaceSearchResults(lat: Double, lon: Double, input: String, completion: @escaping ([Place]) -> Void) {
        
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
                for (i, prediction) in (resultResponse["predictions"] as! [AnyObject]).enumerated() where i < 3 {
                    let place = Place(id: prediction["place_id"] as! String, description: prediction["description"] as! String)
                    placeArray.append(place)
                }
                completion(placeArray)
            }
        }
        
    }
}
