//
//  HeaderDirectionsTableViewCell.swift
//  TransitApp
//
//  Created by Pietro Santececca on 25/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class HeaderDirectionsTableViewCell: UITableViewCell {
    
    var cellModel: DirectionsOptionViewModel? {
        didSet {
            headerDirectionsView.model = cellModel
        }
    }

    @IBOutlet weak var headerDirectionsView: HeaderDirectionsView!
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        headerDirectionsView.directionsCollectionView.delegate = dataSourceDelegate
        headerDirectionsView.directionsCollectionView.dataSource = dataSourceDelegate
        headerDirectionsView.directionsCollectionView.tag = row
        headerDirectionsView.directionsCollectionView.reloadData()
    }
}

