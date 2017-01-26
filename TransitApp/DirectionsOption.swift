//
//  DirectionsOption.swift
//  TransitApp
//
//  Created by Pietro Santececca on 24/01/17.
//  Copyright © 2017 Tecnojam. All rights reserved.
//

import Foundation

public struct DirectionsOption {
    var mode: String
    var provider: String
    var price: Price?
    var directions: [Direction]
}
