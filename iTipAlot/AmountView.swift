//
//  AmountView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/14/25.
//
import SwiftUI

struct AmountView: View {

    @Binding var viewModel: MainViewModel
    @FocusState var amountIsFocused: Bool // Take FocusState as a parameter

    var body: some View {
        HStack {
            Image(systemName: "dollarsign")
                .foregroundStyle(.primary)
                .font(.system(size: 40))
                .bold()

            TextField("How much?", text: $viewModel.checkAmount)
                .foregroundStyle(.primary)
                .font(.system(size: 40))
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
        }
    }
}
#Preview {
    AmountView(viewModel: .constant(MainViewModel()))
}
