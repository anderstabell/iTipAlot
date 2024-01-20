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
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    @State private var color: Color = .primary
    private var colorData = ColorData()
    
    let tipPercentages = [10, 15, 20, 25, 30, 0]
    
    var subTotalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let subAmountPerPerson = checkAmount / peopleCount
        
        return subAmountPerPerson
    }
    /// ``TODO: Make tip per person work!!!!!!!`
    var tipPerPerson: Double {
        
        
        return 0
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
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
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section("Select tip amount") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
//                    .pickerStyle(.segmented)
                }
                
                Section("Sub total per person") {
                    Text(subTotalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Tip per person") {
                    Text(tipPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Split The 🧾")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .foregroundStyle(color)
            ColorPicker(selection: $color, supportsOpacity: false) {
                Label("Pick Your Color", systemImage: "paintpalette.fill")
                    .padding()
            }
            .foregroundStyle(color)
            .padding()
            Button("Save color") {
                colorData.saveColor(color: color)
            }
            Spacer()
        }
        .onAppear {
            color = colorData.loadColor()
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
