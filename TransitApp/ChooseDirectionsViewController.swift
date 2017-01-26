//
//  ChooseDirectionsViewController.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit
import MapKit

class ChooseDirectionsViewController: UIViewController {
    
    
    // MARK: - Variables

    var chooseViewModelController: ChooseViewModelController?
    var selectedMode: String? {
        get {
            guard let chooseVMC = chooseViewModelController,
                let indexArray = modeCollectionView.indexPathsForSelectedItems,
                indexArray.count > 0  else {
                    return nil
            }
            return chooseVMC.modeViewModel(at: indexArray[0].row)
        }
    }
    var selectedOption: DirectionsOptionViewModel? {
        get {
            guard let chooseVMC = chooseViewModelController,
                let index = optionsTableView.indexPathForSelectedRow,
                let mode = selectedMode  else {
                    return nil
            }
            return chooseVMC.optionViewModel(mode: mode, index: index.row)
        }
    }
    

    // MARK: - Outlets

    @IBOutlet weak var modeCollectionView: UICollectionView!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var originAddressLabel: UILabel!
    @IBOutlet weak var arrivalAddressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    
    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set user input on the view
        originAddressLabel.text = chooseViewModelController?.searchDirectionsInput.originAddress
        arrivalAddressLabel.text = chooseViewModelController?.searchDirectionsInput.arrivalAddress
        timeLabel.text = chooseViewModelController?.searchDirectionsInput.getTimeAsString()
        
        // Retrive directions
        guard let chooseVMC = chooseViewModelController else { return }
        chooseVMC.retrieveDirections() {

            // Set first mode ad default one
            modeCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let showDirectionsVC = segue.destination as? ShowDirectionsViewController, var option = selectedOption else { return }
        option.startingAddress = chooseViewModelController?.searchDirectionsInput.originAddress
        option.arrivalAddress = chooseViewModelController?.searchDirectionsInput.arrivalAddress
        let showMVC = ShowViewModelController(directionsOption: option)
        showDirectionsVC.showViewModelController = showMVC
    }
}


// MARK: - Table view data source

extension ChooseDirectionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let chooseVMC = chooseViewModelController, let mode = selectedMode else { return 0 }
        return chooseVMC.optionsCount(mode: mode)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderDirectionsTableViewCell", for: indexPath) as? HeaderDirectionsTableViewCell
        guard let chooseVMC = chooseViewModelController, let optionsCell = cell, let mode = selectedMode else {
            return UITableViewCell()
        }
        
        optionsCell.cellModel = chooseVMC.optionViewModel(mode: mode, index: (indexPath as NSIndexPath).row)
        optionsCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        return optionsCell
    }
}


// MARK: - Table view delegate

extension ChooseDirectionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fromChooseToShow", sender: nil)
    }
}


// MARK: - Collcetion view delegate

extension ChooseDirectionsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        optionsTableView.reloadData()
    }
}


// MARK: - Collection view data source

extension ChooseDirectionsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let chooseVMC = chooseViewModelController else { return 0 }
        if collectionView == modeCollectionView {
            return chooseVMC.modesCount
        }
        else {
            guard let mode = selectedMode else { return 0 }
            return chooseVMC.directionsCount(mode: mode, row: collectionView.tag)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == modeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChooseModeCollectionViewCell", for: indexPath) as? ChooseModeCollectionViewCell
            
            guard let chooseVMC = chooseViewModelController, let modesCell = cell else { return UICollectionViewCell() }
            modesCell.cellModel = chooseVMC.modeViewModel(at: (indexPath as NSIndexPath).row)
            return modesCell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderDirectionsCollectionViewCell", for: indexPath) as? HeaderDirectionsCollectionViewCell
            
            guard let chooseVMC = chooseViewModelController, let modesCell = cell, let mode = selectedMode else { return UICollectionViewCell() }
            modesCell.cellModel = chooseVMC.directionViewModel(mode: mode, row: collectionView.tag, index: (indexPath as NSIndexPath).row)
            return modesCell
        }
    }
    
}

