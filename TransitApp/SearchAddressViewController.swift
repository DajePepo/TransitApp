//
//  AutoCompleteAddressViewController.swift
//  TransitApp
//
//  Created by Pietro Santececca on 23/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

protocol SearchFieldDelegate {
    func didSelectPlace(place: Place)
}

class SearchFieldViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SearchFieldDelegate?
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.becomeFirstResponder()
    }
    
    func textFieldDidChange(textField: UITextField) {
        if  let address = textField.text,
            address.characters.count >= 3,
            let location = AppDelegate.sharedDelegate().locationManager?.location?.coordinate
        {
            DataManager.getGooglePlaceSearchResults(lat: location.latitude, lon: location.longitude, input: address, completion: { places in
                // self.googleSearchResultArray = resultArray
                // self.tableView.reloadData()
            })
        }
    }
}

extension SearchFieldViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].description
        return cell
    }
}

extension SearchFieldViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ...
    }
}

