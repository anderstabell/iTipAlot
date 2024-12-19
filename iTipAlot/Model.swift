//
//  Model.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import Foundation
import Observation

@Observable final class Card {
    var cardLabelText = ""
    var totalAmount = 0.0
    var subtotalAmount = 0.0
    var tipAmount = 0.0
}
