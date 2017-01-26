//
//  ViewController.swift
//  TransitApp
//
//  Created by Pietro Santececca on 22/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {


    // MARK: - Variables
    
    let searchViewModelController = SearchViewModelController()
    var searchDirectionsViewController: SearchDirectionsViewController?
    var selectTimeViewController: SelectTimeViewController?
    

    // MARK: - Outlets
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchDirectionsTopMargin: NSLayoutConstraint!
    @IBOutlet weak var userLocationBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var selectTimeViewContainer: UIView!
    @IBOutlet weak var selectTimeViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var selectTimeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchDirectionsContainer: UIView! {
        didSet {
            searchDirectionsContainer.layer.cornerRadius = 5
            searchDirectionsContainer.backgroundColor = UIColor(white: 1, alpha: 0.95)
        }
    }
    @IBOutlet weak var coverBackgroundView: UIView! {
        didSet {
            coverBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideSelectTimeView)))
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func didClickedOnUserLocationButton(_ sender: AnyObject) {
        if let userLocation = searchViewModelController.userLocation() {
            self.mapView.animate(toLocation: userLocation)
        }
    }
    
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Map config
        mapView.camera = GMSCameraPosition(target: Constants.berlinCenter, zoom: Float(Constants.defaultZoomLevel), bearing: 0, viewingAngle: 0)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        // Sub view controllers
        for viewController in self.childViewControllers {
            if let sDVC = viewController as? SearchDirectionsViewController {
                sDVC.searchViewModelController = self.searchViewModelController
                sDVC.configure(withInitialLocation: searchViewModelController.userLocation())
                sDVC.delegate = self
                searchDirectionsViewController = sDVC
            }
            if let sTVC = viewController as? SelectTimeViewController {
                sTVC.delegate = self
                selectTimeViewController = sTVC
            }
        }
        
        // Move out the selectTimeView
        selectTimeViewBottomMargin.constant = -selectTimeViewHeight.constant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    
    // MARK: - Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fromMapToAutocomplete" {
            let searchAddressVC = segue.destination as? SearchAddressViewController
            searchAddressVC?.searchViewModelController = searchViewModelController
            searchAddressVC?.didSelectPlace = { [unowned self] (place) in ////
                if let textField = sender as? UITextField {
                    if textField.tag == TextFieldType.origin.rawValue {
                        self.searchDirectionsViewController?.updateOriginAddress(place: place)
                    }
                    else if textField.tag == TextFieldType.destination.rawValue {
                        self.searchDirectionsViewController?.updateDestinationAddress(place: place)
                    }
                }
            }
        }
        else if segue.identifier == "fromMapToChoose" {
            let chooseDirectionsVC = segue.destination as? ChooseDirectionsViewController
            chooseDirectionsVC?.chooseViewModelController = ChooseViewModelController(input: searchViewModelController.searchInputViewModel)
        }
    }
    
    func showSelectTimeView(withInitialDate date: Date) {
        selectTimeViewController?.configure(withInitialDate: date)
        self.view.insertSubview(coverBackgroundView, belowSubview: selectTimeViewContainer)
        selectTimeViewBottomMargin.constant = 0
        UIView.animate(withDuration: 0.6) { self.view.layoutIfNeeded() }
    }
    
    func hideSelectTimeView() {
        coverBackgroundView.removeFromSuperview()
        selectTimeViewBottomMargin.constant = -selectTimeViewHeight.constant
        UIView.animate(withDuration: 0.6) { self.view.layoutIfNeeded() }
    }
}


// MARK: - Google map delegate

extension MapViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        searchDirectionsTopMargin.constant = searchDirectionsTopMargin.constant == 10 ? -400 : 10
        userLocationBottomMargin.constant = userLocationBottomMargin.constant == 35 ? -100 : 35
        UIView.animate(withDuration: 0.6) { self.view.layoutIfNeeded() }
    }
}


// MARK: - Search directions delegate

extension MapViewController: SearchDirectionsDelegate {
    
    func searchExactAddress(sender: UITextField) {
        self.performSegue(withIdentifier: "fromMapToAutocomplete", sender: sender)
    }
    
    func selectRightTime(initialDate: Date) {
        showSelectTimeView(withInitialDate: initialDate)
    }
    
    func askForDirections(input: SearchDirectionInputViewModel) {
        self.performSegue(withIdentifier: "fromMapToChoose", sender: nil)
    }
}


// MARK: - Select time delegate

extension MapViewController: SelectTimeProtocol {
    
    func dismissSelectTimeView() {
        self.hideSelectTimeView()
    }

    func updateTime(type: TimeType, time: Date) {
        self.hideSelectTimeView()
        self.searchDirectionsViewController?.updateTime(type: type, time: time)
    }
}



