//
//  MapViewModel.swift
//  TransitApp
//
//  Created by Pietro Santececca on 22/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import MapKit

class SearchViewModelController {
    
    fileprivate var placeViewModelList: [PlaceViewModel] = []
    var searchInputViewModel = SearchDirectionInputViewModel()
    
    var placesCount: Int {
        return placeViewModelList.count
    }

    func placeViewModel(at index: Int) -> PlaceViewModel {
        return placeViewModelList[index]
    }

    func updateSearchInputViewModel(originAddress: String? = nil,
                                    originLocation: CLLocationCoordinate2D? = nil,
                                    arrivalAddress: String? = nil,
                                    arrivalLocation: CLLocationCoordinate2D? = nil,
                                    timeType: TimeType? = nil,
                                    time: Date? = nil, success: (SearchDirectionInputViewModel?) -> Void ) {
        
        searchInputViewModel = SearchDirectionInputViewModel(originAddress: originAddress ?? searchInputViewModel.originAddress,
                                                    originLocation: originLocation ?? searchInputViewModel.originLocation,
                                                    arrivalAddress: arrivalAddress ?? searchInputViewModel.arrivalAddress,
                                                    arrivalLocation: arrivalLocation ?? searchInputViewModel.arrivalLocation,
                                                    timeType: timeType ?? searchInputViewModel.timeType,
                                                    time: time ?? searchInputViewModel.time)
        
        success(searchInputViewModel)
    }
    
    func switchSearchInputAddresses(success: (SearchDirectionInputViewModel?) -> Void) {
        searchInputViewModel = SearchDirectionInputViewModel(originAddress: searchInputViewModel.arrivalAddress,
                                                             originLocation: searchInputViewModel.arrivalLocation,
                                                             arrivalAddress: searchInputViewModel.originAddress,
                                                             arrivalLocation: searchInputViewModel.originLocation,
                                                             timeType: searchInputViewModel.timeType,
                                                             time: searchInputViewModel.time)
        
        success(searchInputViewModel)
    }

    func emptyPlacesList() {
        placeViewModelList.removeAll()
    }

    func retrievePlaces(placeDescription: String, success: (() -> Void)?) {
        
        if  let location = AppDelegate.sharedDelegate().locationManager?.location?.coordinate
        {
            if placeDescription.characters.count >= 3 {
                PlaceDataManager.retreivePlacesFromGoogle(lat: location.latitude, lon: location.longitude, input: placeDescription) {
                    [unowned self] (places) in
                    self.placeViewModelList = places.map() { PlaceViewModel(id: $0.id, description: $0.description) }
                    success?()
                }
            }
            else {
                self.placeViewModelList.removeAll()
                success?()
            }
        }
        
    }
    
    func userLocation() -> CLLocationCoordinate2D? {
        return AppDelegate.sharedDelegate().locationManager?.location?.coordinate
    }
    
    func selectPlace(at index: Int, success: ((PlaceViewModel) -> Void)?) {
        let selectedPlace = placeViewModelList[index]
        PlaceDataManager.retreivePlaceDetailsFromGoogle(placeId: selectedPlace.id, placeDescription: selectedPlace.description) {
            place in
            success?(PlaceViewModel(model: place))
        }
    }
    
}
