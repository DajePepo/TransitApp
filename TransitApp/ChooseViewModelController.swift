//
//  ChooseViewModelController.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import MapKit

class ChooseViewModelController {
    
    fileprivate var modeViewModelList = [String]()
    fileprivate var optionViewModelList = [DirectionsOptionViewModel]()
    var searchDirectionsInput: SearchDirectionInputViewModel
    
    init(input: SearchDirectionInputViewModel) {
        self.searchDirectionsInput = input
    }
    
    var modesCount: Int {
        return modeViewModelList.count
    }
    
    func optionsCount(mode: String) -> Int {
        return optionViewModelList.filter(){ $0.mode == mode }.count
    }
    
    func directionsCount(mode: String, row: Int) -> Int {
        return optionViewModelList.filter(){ $0.mode == mode }[row].directions.count
    }
    
    func modeViewModel(at index: Int) -> String {
        return modeViewModelList[index]
    }

    func optionViewModel(mode: String, index: Int) -> DirectionsOptionViewModel {
        return optionViewModelList.filter(){ $0.mode == mode }[index]
    }
    
    func directionViewModel(mode: String, row: Int, index: Int) -> DirectionViewModel {
        return optionViewModelList.filter(){ $0.mode == mode }[row].directions[index]
    }
    
    func retrieveDirections(success: () -> Void) {
        guard let origin = searchDirectionsInput.originLocation, let arrival = searchDirectionsInput.arrivalLocation else {
            return
        }
        let timeType = searchDirectionsInput.timeType
        let time = searchDirectionsInput.time
        self.retrieveDirections(originLocation: origin, arrivalLocation: arrival, timeType: timeType ?? .arrival, time: time ?? Date())
        success()
    }
    
    func retrieveDirections(originLocation: CLLocationCoordinate2D, arrivalLocation: CLLocationCoordinate2D, timeType: TimeType, time: Date) {
        
        // Mode list
        let options = DirectionsDataManager.retreiveDirectionsOptions(originLocation: originLocation, arrivalLocation: arrivalLocation, timeType: timeType, time: time)
        self.optionViewModelList = options.map(){ DirectionsOptionViewModel(model: $0) }
        
        // Option list
        for option in optionViewModelList {
            if !modeViewModelList.contains(option.mode) {
                modeViewModelList.append(option.mode)
            }
        }
        
    }
    
    func selectOption() {
        
    }
}
