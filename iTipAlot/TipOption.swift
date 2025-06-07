//
//  TipOption.swift
//  iTipAlot
//
//  Created by Anders Tabell on 6/7/25.
//

import Foundation

/// Represents the two ways a tip can be specified: as a percentage of the subtotal
/// or as a fixed custom dollar amount.
/// This enum is used by ``MainViewModel/tipOption`` to determine the calculation logic for the tip.
enum TipOption {
    /// Tip is calculated as a percentage of the `checkAmount`.
    /// The percentage value is stored in ``MainViewModel/tipPercentage``.
    case percentage
    /// Tip is a fixed dollar amount specified by ``MainViewModel/customTipAmount``.
    case customAmount
}
