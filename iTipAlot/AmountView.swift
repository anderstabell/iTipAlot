//
//  AmountView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/14/25.
//
import SwiftUI

struct AmountView: View {
    
    @Binding var vm: MainViewModel
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "dollarsign")
                .foregroundStyle(.primary)
                .font(.system(size: 60))
                .bold()
            
            TextField("How much?", text: $vm.checkAmount)
                .foregroundStyle(.primary)
                .font(.system(size: 50))
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
            
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}
