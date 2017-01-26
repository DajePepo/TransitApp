//
//  AutoCompleteAddressViewController.swift
//  TransitApp
//
//  Created by Pietro Santececca on 23/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit
import MapKit

class SearchAddressViewController: UIViewController {

    
    // MARK: - Varibales
    
    var searchViewModelController: SearchViewModelController?
    var didSelectPlace: ((PlaceViewModel) -> Void)?

    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    

    // MARK: - Actions
    
    @IBAction func didClickedCancelSearching(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        searchViewModelController?.emptyPlacesList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.becomeFirstResponder()
    }
    
    func textFieldDidChange(textField: UITextField) {
        if  let userInput = textField.text {
            
            searchViewModelController?.retrievePlaces(placeDescription: userInput) {
                [unowned self] (result) in
                self.tableView.reloadData()
            }
        }
    }
}


// MARK: - Table view data source

extension SearchAddressViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mapVMC = searchViewModelController else {
            return 0
        }
        return mapVMC.placesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? PlaceTableViewCell
        guard let placesCell = cell else {
            return UITableViewCell()
        }
        
        placesCell.cellModel = searchViewModelController?.placeViewModel(at: (indexPath as NSIndexPath).row)
        return placesCell
    }
}


// MARK: - Table view delegate

extension SearchAddressViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.searchViewModelController?.selectPlace(at: indexPath.row, success: self.didSelectPlace)
        }
    }
}

