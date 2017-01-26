//
//  AppDelegate.swift
//  TransitApp
//
//  Created by Pietro Santececca on 22/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?
    
    class func sharedDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Google Map
        GMSServices.provideAPIKey(Constants.googleKey)
        GMSPlacesClient.provideAPIKey(Constants.googleKey)
        
        // Location manager
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        locationManager!.startUpdatingLocation()
        
        return true
    }

}

