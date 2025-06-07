//
//  TipSelectionView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/23/25.
//

import SwiftUI

struct TipSelectionView: View {
    
    @Binding var viewModel: MainViewModel
    @FocusState.Binding var customTipFocused: Bool
    
    var body: some View {
        /// This will give you the ``TipOption`` between percentage, and custom dollar amount
        ZStack {
            VStack {
                Slider(value: $viewModel.tipPercentage, in: 0...100, step: 1)
                    .tint(.secondary)
                Text("Tip Percentage: \((viewModel.tipPercentage / 100.0).formatted(.percent.precision(.fractionLength(0))))")
                    .padding(.bottom)
            }
            .opacity(viewModel.tipOption == .percentage ? 1.0 : 0.0)
            .allowsHitTesting(viewModel.tipOption == .percentage)
            
            TextField("Custom Total Tip", value: $viewModel.customTipAmount, format: .currency(code: "USD"))
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .focused($customTipFocused)
                .overlay(
                    
                    Group {
                        if viewModel.tipOption == .customAmount && viewModel.customTipAmount != nil {
                            Button {
                                viewModel.customTipAmount = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                        }
                    }
                    , alignment: .trailing
                )
                .opacity(viewModel.tipOption == .customAmount ? 1.0 : 0.0)
                .allowsHitTesting(viewModel.tipOption == .customAmount)
            
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.tipOption)
    }
}

#Preview {
    
    @Previewable @State var viewModel = MainViewModel()
    @Previewable @FocusState var focus: Bool
    
    VStack {
        
        Picker("Preview Option", selection: $viewModel.tipOption.animation()) {
            Text("Percentage").tag(TipOption.percentage)
            Text("Custom").tag(TipOption.customAmount)
        }
        .padding(.bottom)
        .pickerStyle(.segmented)
        
        TipSelectionView(
            viewModel: $viewModel,
            customTipFocused: $focus
        )
    }
    .padding()
}
