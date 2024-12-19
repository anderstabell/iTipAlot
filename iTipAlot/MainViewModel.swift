//
//  MainViewModel.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import Foundation
import Observation

@Observable final class MainViewModel {
    
    /// Properties for the ``CardView``
    var checkAmount = ""
    var numberOfPeople = 2
    var tipPercentage = 2
    
    /// Tip amount that can be selected when doing the calculations
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var subTotal: Double { Double(checkAmount) ?? 0 }
    
    var subTotalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let subTotal = Double(checkAmount) ?? 0
        return subTotal / peopleCount
    }
    
    var tipValue: Double {
        let tipSelection = Double (tipPercentages[tipPercentage])
        let subTotal = Double(checkAmount) ?? 0
        return subTotal / 100 * tipSelection
    }
    
    var tipValuePerPerson: Double { tipValue / Double(numberOfPeople) }
    
    var totalAmountWithTip: Double {
        let tipSelection = Double (tipPercentages[tipPercentage])
        let subTotal = Double(checkAmount) ?? 0
        let tipValue = subTotal / 100 * tipSelection
        let grandTotal = subTotal + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let amountPerPerson = totalAmountWithTip / peopleCount
        return amountPerPerson
    }
}
