//
//  DirectionTableViewCell.swift
//  TransitApp
//
//  Created by Pietro Santececca on 25/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class DirectionTableViewCell: UITableViewCell {

    var cellModel: StopViewModel? {
        didSet {
            bindViewModel()
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lineView: UIButton!

    func bindViewModel() {
        timeLabel.text = cellModel?.time
        nameLabel.text = cellModel?.name
        lineView.backgroundColor = UIColor(hexString: cellModel?.color ?? "#000000")
    }

}
