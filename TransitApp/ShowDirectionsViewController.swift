//
//  ShowDirectionsViewController.swift
//  TransitApp
//
//  Created by Pietro Santececca on 25/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit
import GoogleMaps

class ShowDirectionsViewController: UIViewController {


    // MARK: - Variables

    var showViewModelController: ShowViewModelController?
    var selectedSection: Int?
    

    // MARK: - Outlets

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var headerDirectionsView: HeaderDirectionsView!
    @IBOutlet weak var directionsTable: UITableView! {
        didSet {
            let headerNib = UINib(nibName: "HeaderSectionDirectionView", bundle: nil)
            directionsTable.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderSectionDirectionView")
            directionsTable.sectionFooterHeight = 0
            directionsTable.contentInset = UIEdgeInsetsMake(20, 0, 20, 0)
        }
    }
    

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Header (directions summary)
        headerDirectionsView.model = showViewModelController?.headerDirectionsViewModel()
        headerDirectionsView.directionsCollectionView.dataSource = self
        
        // Map config
        mapView.isMyLocationEnabled = true
        //mapView.delegate = self
        
        // Add origin marker
        guard let originPosition = showViewModelController?.originPosition() else { return }
        mapView.addOriginMarker(location: originPosition)
        
        
        // Add destination marker
        guard let destinationPosition = showViewModelController?.destinationPosition() else { return }
        mapView.addDestinationMarker(location: destinationPosition)
    
        // Show path
        if let showVMC = showViewModelController {
            mapView.drawPath(directions: showVMC.pathSegments())
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        // Set map zoom
        guard let originPosition = showViewModelController?.originPosition(),
            let destinationPosition = showViewModelController?.destinationPosition() else {
                return
        }
        mapView.updateCameraAccordingMarkersLocation(locations: [originPosition, destinationPosition])
    }

}


// MARK: - Table view data source

extension ShowDirectionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let showVMC = showViewModelController, section == selectedSection else { return 0 }
        return showVMC.stopsCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionTableViewCell", for: indexPath) as? DirectionTableViewCell
        guard let stopsCell = cell, let showVMC = showViewModelController else {
            return UITableViewCell()
        }
        
        stopsCell.cellModel = showVMC.stopViewModel(section: indexPath.section, index: indexPath.row)
        return stopsCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let showVMC = showViewModelController else { return 0 }
        return showVMC.directionsCount
    }
}


// MARK: - Table view delegate

extension ShowDirectionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = DirectionsTableFooterView.loadFromNib()
        footerView?.footerModel = showViewModelController?.footerDirectionsViewModel()
        return section == (tableView.numberOfSections - 1) ? footerView : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == (tableView.numberOfSections - 1) ? 25.0 : 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = directionsTable.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSectionDirectionView")
        guard let directionsHeader = header as? HeaderSectionDirectionView, let showVMC = showViewModelController else {
            return UITableViewCell()
        }
        
        directionsHeader.selected = (selectedSection == section)
        directionsHeader.model = showVMC.directionViewModel(at: section)
        directionsHeader.tag = section
        directionsHeader.delegate = self
        return directionsHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90.0
    }
}


// MARK: - Table header delegate

extension ShowDirectionsViewController: HeaderSectionDirectionProtocol {
    
    func showHideStopsList(section: Int) {
        selectedSection = (selectedSection == section) ? nil : section
        directionsTable.reloadData()
    }
}


// MARK: - Collection view data source

extension ShowDirectionsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let showVMC = showViewModelController else { return 0 }
        return showVMC.directionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderDirectionsCollectionViewCell", for: indexPath) as? HeaderDirectionsCollectionViewCell
            
        guard let directionsCell = cell, let showVMC = showViewModelController else { return UICollectionViewCell() }
        directionsCell.cellModel = showVMC.directionViewModel(at: (indexPath as NSIndexPath).row)
        return directionsCell
    }
    
}



