//
//  HeaderSectionDirectionView.swift
//  TransitApp
//
//  Created by Pietro Santececca on 25/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol HeaderSectionDirectionProtocol {
    func showHideStopsList(section: Int)
}

class HeaderSectionDirectionView: UITableViewHeaderFooterView {

    
    // MARK: - Variables
    
    var delegate: HeaderSectionDirectionProtocol?
    var selected = false
    var model: DirectionViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    
    // MARK: - Outlets

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startingAddress: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var terminalLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var stopsNumberLabel: UILabel!
    @IBOutlet weak var stopsButton: UIButton!
    @IBOutlet weak var travelModeLabel: UILabel!
    @IBOutlet weak var travelModeContainer: UIView!
    @IBOutlet weak var terminalContainer: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var lineView: UIView!
    
    
    // MARK: - Actions

    @IBAction func didClickedStopsButton(_ sender: AnyObject) {
        delegate?.showHideStopsList(section: self.tag)
    }
    
    
    func bindViewModel() {
        timeLabel.text = model?.time
        startingAddress.text = model?.startingAddress
        nameLabel.text = model?.name
        terminalLabel.text = model?.terminal
        durationLabel.text = model?.duration
        lineView.backgroundColor = UIColor(hexString: model?.color ?? "#000000")
        
        if selected { arrowImage.image = UIImage(named: "ArrowUp") }
        else { arrowImage.image = UIImage(named: "ArrowDown") }
        
        if let model = model, model.numStops > 0 {
            stopsNumberLabel.text = "\(model.numStops) stops"
            stopsNumberLabel.isHidden = false
            stopsButton.isEnabled = true
            travelModeContainer.isHidden = true
            terminalContainer.isHidden = false
//            arrowImage.isHidden = false
        }
        else {
            stopsNumberLabel.isHidden = true
            stopsButton.isEnabled = false
            travelModeContainer.isHidden = false
            terminalContainer.isHidden = true
            travelModeLabel.text = model?.travelMode
            arrowImage.image = UIImage()
//            arrowImage.isHidden = true
        }
    }

    
    
}
