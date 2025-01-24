//
//  AmountView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/14/25.
//
import SwiftUI

struct AmountView: View {
    
    @Binding var viewModel: MainViewModel
    
    @FocusState.Binding var amountIsFocused: Bool
    
    /// This string acts as an intermediary between the TextField and the viewModel.checkAmount.
    @State private var textFieldValue = ""
    
    var body: some View {
        TextField("How much?", text: $textFieldValue)
            .foregroundStyle(.primary)
            .font(.system(size: 40))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
            .onChange(of: textFieldValue) {
                viewModel.updateCheckAmount($1)
            }
            .onAppear{
                if let amount = viewModel.checkAmount {
                    textFieldValue = String(amount)
                }
            }
    }
}
#Preview {
    AmountView(viewModel: .constant(MainViewModel()))
}
