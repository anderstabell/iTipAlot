//
//  AmountView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/14/25.
//
import SwiftUI

struct AmountView: View {
    
    @Binding var viewModel: MainViewModel
    
    /// Take FocusState as a parameter
    @FocusState var amountIsFocused: Bool
    
    /// This string acts as an intermediary between the TextField and the viewModel.checkAmount.
    @State private var textFieldValue = ""
    
    var body: some View {
        TextField("How much?", text: $textFieldValue)
            .foregroundStyle(.primary)
            .font(.system(size: 40))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
        
        /// This modifier detects when the textFieldValue changes. Inside the closure, viewModel `.updateCheckAmount(newValue)` is called to update the checkAmount in the view model.
        /// - seealso: ``MainViewModel/updateCheckAmount(_:)``
            .onChange(of: textFieldValue) { oldValue, newValue in
                viewModel.updateCheckAmount(newValue)
            }
        /// This executes once when the view is loaded and sets the textFieldValue to the string value of checkAmount if it exists.
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
