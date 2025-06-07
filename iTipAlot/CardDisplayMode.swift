//
//  CardDisplayMode.swift
//  iTipAlot
//
//  Created by Anders Tabell on 6/7/25.
//

import Foundation

/// Defines the two display modes for the ``CardView``.
enum CardDisplayMode {
    case perPerson
    case total
    
    /// Provides the appropriate label text for the view's GroupBox.
    var labelText: String {
        switch self {
        case .perPerson:
            return "PER PERSON"
        case .total:
            return "TOTAL"
        }
    }
}
