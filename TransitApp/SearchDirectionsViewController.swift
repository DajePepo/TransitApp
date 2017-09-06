//
//  SearchDirectionsView.swift
//  TransitApp
//
//  Created by Pietro Santececca on 22/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit
import MapKit

protocol SearchDirectionsDelegate {
    func searchExactAddress(sender: UITextField)
    func selectRightTime(initialDate: Date)
    func askForDirections(input: SearchDirectionInputViewModel)
}

enum TextFieldType: Int {
    case origin
    case destination
}

class SearchDirectionsViewController: UIViewController {
    
    
    // MARK: - Variables
    
    var delegate: SearchDirectionsDelegate?
    var searchViewModelController: SearchViewModelController?

    
    // MARK: - Outlets
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var originAddressTextField: UITextField! {
        didSet {
            originAddressTextField.addTarget(self, action: #selector(didClickedOnOriginTextField(textField:)) , for: UIControlEvents.touchDown)
            originAddressTextField.tag = TextFieldType.origin.rawValue
        }
    }
    @IBOutlet weak var destinationAddressTextField: UITextField! {
        didSet {
            destinationAddressTextField.addTarget(self, action: #selector(didClickedOnDestinationTextField(textField:)) , for: UIControlEvents.touchDown)
            destinationAddressTextField.tag = TextFieldType.destination.rawValue
        }
    }
    
    
    // MARK: - Actions

    @IBAction func didClickedOnGoButton(_ sender: AnyObject) {
        guard let input = searchViewModelController?.searchInputViewModel else { return }
        delegate?.askForDirections(input: input)
    }
    
    @IBAction func didClickedOnTimeButton(_ sender: AnyObject) {
        delegate?.selectRightTime(initialDate: searchViewModelController?.searchInputViewModel.time ?? Date())
    }
    
    @IBAction func didClickedOnSwitchButton(_ sender: AnyObject) {
        searchViewModelController?.switchSearchInputAddresses(success: updateSearchInputLayout)
    }

    
    func configure(withInitialLocation location: CLLocationCoordinate2D?) {
        searchViewModelController?.updateSearchInputViewModel(originAddress: "Current location", originLocation: location, success: updateSearchInputLayout)
    }

    func updateSearchInputLayout(searchInput: SearchDirectionInputViewModel?) {
        originAddressTextField.text = searchInput?.originAddress
        destinationAddressTextField.text = searchInput?.arrivalAddress
        timeButton.setTitle(searchInput?.getTimeAsString(), for: .normal)
        if let _ = searchInput?.originLocation, let _ = searchInput?.arrivalLocation {
            self.goButton.isEnabled = true
        }
        else { self.goButton.isEnabled = false }
    }

    
    func didClickedOnOriginTextField(textField: UITextField) {
        delegate?.searchExactAddress(sender: textField)
    }
    
    func updateOriginAddress(place: PlaceViewModel) {
        searchViewModelController?.updateSearchInputViewModel(originAddress: place.description, originLocation: place.coordinate, success: updateSearchInputLayout)
    }
    
    func didClickedOnDestinationTextField(textField: UITextField) {
        delegate?.searchExactAddress(sender: textField)
    }
    
    func updateDestinationAddress(place: PlaceViewModel) {
        searchViewModelController?.updateSearchInputViewModel(arrivalAddress: place.description, arrivalLocation: place.coordinate, success: updateSearchInputLayout)
     }
    
    func updateTime(type: TimeType?, time: Date?) {
        searchViewModelController?.updateSearchInputViewModel(timeType: type, time: time, success: updateSearchInputLayout)
    }
    
}
