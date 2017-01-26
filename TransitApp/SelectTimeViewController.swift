//
//  SelectTimeViewController.swift
//  TransitApp
//
//  Created by Pietro Santececca on 23/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import UIKit

enum TimeType: String {
    case start = "Start"
    case arrival = "Arrival"
}

protocol SelectTimeProtocol {
    func dismissSelectTimeView()
    func updateTime(type: TimeType, time: Date)
}

class SelectTimeViewController: UIViewController {
    
    
    // MARK: - Variables

    var delegate: SelectTimeProtocol?


    // MARK: - Outlets

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    // MARK: - Actions

    @IBAction func didClickedOnCancelButton(_ sender: AnyObject) {
        delegate?.dismissSelectTimeView()
    }
    
    @IBAction func didClickedOnConfirmButton(_ sender: AnyObject) {
        if  let selectedOption = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex),
            let timeType = TimeType(rawValue: selectedOption) {
            delegate?.updateTime(type: timeType, time: datePicker.date)
        }
    }
    
    
    func configure(withInitialDate date: Date) {
        datePicker.setDate(date, animated: false)
    }
    
}
