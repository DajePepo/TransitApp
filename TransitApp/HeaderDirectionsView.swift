//
//  HeaderDirectionsView.swift
//  TransitApp
//
//  Created by Pietro Santececca on 25/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

class HeaderDirectionsView: UIView {
    
    var model: DirectionsOptionViewModel? {
        didSet {
            bindViewModel()
        }
    }

    @IBOutlet var view: UIView!
    @IBOutlet weak var directionsCollectionView: UICollectionView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var startingTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        let bundle = Bundle(for: type(of: self))
        UINib(nibName: "HeaderDirectionsView", bundle: bundle).instantiate(withOwner: self, options: nil)
        
        addSubview(view)
        view.frame = bounds
        
        directionsCollectionView.register(UINib(nibName: "HeaderDirectionsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderDirectionsCollectionViewCell")
    }
    
    func bindViewModel() {
        priceLabel.text = model?.price
        startingTimeLabel.text = model?.startingTime
        arrivalTimeLabel.text = model?.arrivalTime
        durationLabel.text = model?.duration
    }
    
}
