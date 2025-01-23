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
        /// This will give you the option between percentage, and custom dollar amount
        /// - seealso: ``TipOption``
        if viewModel.tipOption == .percentage {
            Slider(value: $viewModel.tipPercentage, in: 0...100, step: 1)
                .tint(.secondary)
            Text("Tip Percentage: \(Int(viewModel.tipPercentage))%")
                .padding(.bottom)
        } else {
            HStack {
                Image(systemName: "dollarsign")
                    .foregroundStyle(.primary)
                    .font(.system(size: 30))
                    .bold()
                TextField("Custom $ Tip", value: $viewModel.customTipAmount, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .opacity(0.5)
                    .focused($customTipFocused)
                    .onSubmit {
                        customTipFocused = false
                    }
            }
        }
    }
}

#Preview {
    TipSelectionView(viewModel: .constant(MainViewModel()))
}
