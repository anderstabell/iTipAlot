//
//  MainViewModel.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import Foundation
import Observation

/// Overall calculations for the three ``CardView`` properties
@Observable final class MainViewModel {
    
    /// Properties for calculating the check
    var checkAmount = ""
    var numberOfPeople = 2
    var tipPercentage = 2
    
    /// Tip amount that can be selected when doing the calculations
    let tipPercentages = [10, 15, 20, 25, 0]
    
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
        let tipSelection = Double (tipPercentages[tipPercentage])
        let subTotal = Double(checkAmount) ?? 0
        return subTotal / 100 * tipSelection
    }
    
    /// Calculation for tip value per person
    var tipValuePerPerson: Double { tipValue / Double(numberOfPeople) }
    
    /// Calculation for total amount, tip included
    var totalAmountWithTip: Double {
        let tipSelection = Double (tipPercentages[tipPercentage])
        let subTotal = Double(checkAmount) ?? 0
        let tipValue = subTotal / 100 * tipSelection
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
