//
//  HeaderDirectionsCollectionViewCell.swift
//  TransitApp
//
//  Created by Pietro Santececca on 25/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit
import ImageLoader

class HeaderDirectionsCollectionViewCell: UICollectionViewCell {
    
    var cellModel: DirectionViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    @IBOutlet weak var directionIcon: UIImageView!
    @IBOutlet weak var directionTitle: UILabel!
    
    func bindViewModel() {
        directionTitle.text = cellModel?.name ?? cellModel?.travelMode
        directionIcon.image = UIImage(named: "IconPlaceholderBig")
    }
}
