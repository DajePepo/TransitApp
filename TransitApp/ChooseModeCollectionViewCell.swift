//
//  ChooseWayCollectionViewCell.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class ChooseModeCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            selectionBackground.isHidden = !isSelected
        }
    }
    
    var cellModel: String? {
        didSet {
            bindViewModel()
        }
    }

    @IBOutlet weak var modeIcon: UIImageView!
    @IBOutlet weak var modeTitle: UILabel!
    @IBOutlet weak var selectionBackground: UIView! {
        didSet {
            selectionBackground.layer.cornerRadius = 6
            selectionBackground.isHidden = true
        }
    }
    
    func bindViewModel() {
        modeIcon.image = UIImage(named: "ModeIconSmall")
        modeTitle.text = cellModel
    }
}
