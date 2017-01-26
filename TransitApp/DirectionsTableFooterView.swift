//
//  DirectionsTableFooterView.swift
//  TransitApp
//
//  Created by Pietro Santececca on 26/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class DirectionsTableFooterView: UIView {

    var footerModel: DirectionsOptionViewModel? {
        didSet {
            bindViewModel()
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    class func loadFromNib() -> DirectionsTableFooterView? {
        let xib = UINib(nibName: "DirectionsTableFooterView", bundle: nil)
        return xib.instantiate(withOwner: nil, options: nil)[0] as? DirectionsTableFooterView
    }
    
    func bindViewModel() {
        timeLabel.text = footerModel?.arrivalTime
        nameLabel.text = footerModel?.arrivalAddress
    }

}
