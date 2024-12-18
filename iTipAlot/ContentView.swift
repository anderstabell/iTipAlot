//
//  ContentView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    private var subTotal: Double { Double(checkAmount) }
    
    private var subTotalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let subTotal = Double(checkAmount)
        return subTotal / peopleCount
    }
    
    private var tipValue: Double {
        let tipSelection = Double (tipPercentages[tipPercentage])
        let subTotal = Double(checkAmount)
        return subTotal / 100 * tipSelection
    }
    
    private var tipValuePerPerson: Double { tipValue / Double(numberOfPeople) }
    
    private var totalAmountWithTip: Double {
        let tipSelection = Double (tipPercentages[tipPercentage])
        let subTotal = Double(checkAmount)
        let tipValue = subTotal / 100 * tipSelection
        let grandTotal = subTotal + tipValue
        return grandTotal
    }
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let amountPerPerson = totalAmountWithTip / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(0..<101) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section("Select tip amount") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Sub total per person") {
                    Text(subTotalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Tip per person") {
                    Text(tipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Split The Check")
            .navigationBarTitleDisplayMode(.automatic)
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

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
