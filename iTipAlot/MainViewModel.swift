//
//  MainViewModel.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import Foundation
import Observation

/// Tip option with percentage or custom dollar amount
enum TipOption {
    case percentage
    case customAmount
}

/// Overall calculations for the ``CardView`` properties
@Observable final class MainViewModel {

    /// Properties for calculating the check
    var checkAmount = ""
    var numberOfPeople = 2
    var tipPercentage: Double = 20
    var customTipAmount: Double = 0
    var tipOption: TipOption = .percentage

    /// This will check if the `checkAmount` can be a `Double`. If not, make it a zero (0)
    var subTotal: Double { Double(checkAmount) ?? 0 }

    /// Calculation for the subtotal per person
    var subTotalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let subTotal = Double(checkAmount) ?? 0
        return subTotal / peopleCount
    }

    /// Calculation for the tip value
    var tipValue: Double {
        let subTotal = Double(checkAmount) ?? 0
        switch tipOption {
        case .percentage:
            return subTotal / 100 * tipPercentage
        case .customAmount:
            return customTipAmount
        }
    }

    /// Calculation for tip value per person
    var tipValuePerPerson: Double { tipValue / Double(numberOfPeople) }

    /// Calculation for total amount, tip included
    var totalAmountWithTip: Double {
        let subTotal = Double(checkAmount) ?? 0
        let tipValue = self.tipValue
        let grandTotal = subTotal + tipValue
        return grandTotal
    }

    /// Calculation for the grand total per person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let amountPerPerson = totalAmountWithTip / peopleCount
        return amountPerPerson
    }
}
