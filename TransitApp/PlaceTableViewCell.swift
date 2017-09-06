//
//  SearchAddressTableViewCell.swift
//  TransitApp
//
//  Created by Pietro Santececca on 23/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    var cellModel: PlaceViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        textLabel?.text = cellModel?.description
    }
}
