//
//  TipSelectionView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/23/25.
//

import SwiftUI

struct TipSelectionView: View {
    
    @Binding var viewModel: MainViewModel
    @FocusState var customTipFocused: Bool
    
    var body: some View {
        /// This will give you the ``TipOption`` between percentage, and custom dollar amount
        if viewModel.tipOption == .percentage {
            Slider(value: $viewModel.tipPercentage, in: 0...100, step: 1)
                .tint(.secondary)
            Text("Tip Percentage: \(Int(viewModel.tipPercentage))%")
                .padding(.bottom)
        } else {
            TextField("Custom Tip $$$", value: $viewModel.customTipAmount, format: .currency(code: "USD"))
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .focused($customTipFocused)
        }
    }
}

#Preview {
    TipSelectionView(viewModel: .constant(MainViewModel()))
}
