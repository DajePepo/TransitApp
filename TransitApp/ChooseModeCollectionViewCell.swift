//
//  ChooseWayCollectionViewCell.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class ChooseWayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wayIcon: UIImageView!
    @IBOutlet weak var selectionBackground: UIView! {
        didSet {
            selectionBackground.layer.cornerRadius = 6
            selectionBackground.isHidden = true
        }
    }
    
    override var isSelected: Bool {
        didSet {
            selectionBackground.isHidden = !isSelected
        }
    }
    
    var cellModel: DirectionsModeViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        guard let model = cellModel else {
            return
        }
    
        wayIcon.image = UIImage(named: model.iconUrl)
    }
}
