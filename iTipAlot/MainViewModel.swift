//
//  MainViewModel.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import Foundation
import Observation

/// Represents the two ways a tip can be specified: as a percentage of the subtotal
/// or as a fixed custom dollar amount.
///
/// This enum is used by ``MainViewModel/tipOption`` to determine the calculation logic for the tip.
enum TipOption {
    /// Tip is calculated as a percentage of the `checkAmount`.
    /// The percentage value is stored in ``MainViewModel/tipPercentage``.
    case percentage
    /// Tip is a fixed dollar amount specified by ``MainViewModel/customTipAmount``.
    case customAmount
}

/// This class manages the state and logic for calculating tips, designed to be observed by SwiftUI views.
///
/// It holds all input values like check amount, number of people, and tip preferences,
/// and provides computed properties for derived values like tip amount, total per person, etc.
@Observable final class MainViewModel {
    
    // MARK: - Input Properties
    
    /// The initial amount of the check/bill, before any tip.
    /// Entered by the user, typically from a TextField. Optional because it might not be set initially or
    /// could be an invalid number.
    var checkAmount: Double?
    
    /// The number of people splitting the bill. Defaults to 2.
    /// Used to calculate per-person amounts.
    var numberOfPeople = 2
    
    /// The tip percentage to apply if `tipOption` is `.percentage`.
    /// Represented as a whole number (e.g., 20 for 20%). Defaults to 20%.
    var tipPercentage: Double = 20
    
    /// The custom, fixed dollar amount for the tip if `tipOption` is `.customAmount`.
    /// Optional because it's only used when `tipOption` is `.customAmount` and might not be set.
    var customTipAmount: Double?
    
    /// Determines how the tip is calculated, either as a percentage or a custom amount.
    /// Defaults to `.percentage`. See ``TipOption`` for details.
    var tipOption: TipOption = .percentage
    
    // MARK: - Computed Properties for Display
    
    /// The subtotal of the check. Returns `checkAmount` if set, otherwise 0.
    /// This provides a non-optional `Double` for subsequent calculations, ensuring they don't fail
    /// if `checkAmount` is `nil`.
    var subTotal: Double { checkAmount ?? 0 }
    
    /// Calculates the portion of the `subTotal` that each person is responsible for, before tip.
    /// It divides the `subTotal` by the `numberOfPeople`.
    var subTotalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        // Ensure peopleCount is not zero to avoid division by zero,
        // though UI constraints should typically prevent numberOfPeople from being < 1.
        guard peopleCount > 0 else { return subTotal }
        return subTotal / peopleCount
    }
    
    /// Calculates the actual tip amount based on the selected `tipOption`.
    /// - If `tipOption` is `.percentage`, it calculates `subTotal * (tipPercentage / 100)`.
    /// - If `tipOption` is `.customAmount`, it returns `customTipAmount` (or 0 if `customTipAmount` is `nil`).
    var tipValue: Double {
        /// `subTotal` conveniently handles the case where `checkAmount` is nil.
        switch tipOption {
        case .percentage:
            return subTotal / 100 * tipPercentage
        case .customAmount:
            return customTipAmount ?? 0
        }
    }
    
    /// Calculates the portion of the `tipValue` that each person is responsible for.
    /// It divides the total `tipValue` by the `numberOfPeople`.
    var tipValuePerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        guard peopleCount > 0 else { return tipValue }
        return tipValue / peopleCount
    }
    
    /// Calculates the grand total amount, which is the `subTotal` plus the calculated `tipValue`.
    var totalAmountWithTip: Double {
        /// Both `subTotal` and `tipValue` are already computed and handle nil inputs appropriately.
        return subTotal + tipValue
    }
    
    /// Calculates the final amount each person has to pay, including their share of the subtotal and the tip.
    /// It divides the `totalAmountWithTip` by the `numberOfPeople`.
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        guard peopleCount > 0 else { return totalAmountWithTip }
        return totalAmountWithTip / peopleCount
    }
}
