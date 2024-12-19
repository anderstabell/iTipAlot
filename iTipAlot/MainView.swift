//
//  ContentView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/17/24.
//

import SwiftUI

struct MainView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    private var subTotal: Double { Double(checkAmount) ?? 0 }
    
    private var subTotalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let subTotal = Double(checkAmount) ?? 0
        return subTotal / peopleCount
    }
    
    private var tipValue: Double {
        let tipSelection = Double (tipPercentages[tipPercentage])
        let subTotal = Double(checkAmount) ?? 0
        return subTotal / 100 * tipSelection
    }
    
    private var tipValuePerPerson: Double { tipValue / Double(numberOfPeople) }
    
    private var totalAmountWithTip: Double {
        let tipSelection = Double (tipPercentages[tipPercentage])
        let subTotal = Double(checkAmount) ?? 0
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
        VStack(alignment: .center, spacing: 20) {
            CardView(cardLabelText: "PER PERSON", totalAmount: totalPerPerson, subtotalAmount: subTotalPerPerson, tipAmount: tipValuePerPerson)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            CardView(cardLabelText: "TOTAL", totalAmount: totalAmountWithTip, subtotalAmount: subTotal, tipAmount: tipValue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Picker("Tip Percentage", selection: $tipPercentage) {
                ForEach(0..<tipPercentages.count, id: \.self) {
                    Text("\(tipPercentages[$0])%")
                }
            }
            .pickerStyle(.segmented)
            
            TitleView(title: "BILL AMOUNT")
            
            HStack {
                Text("$")
                    .foregroundStyle(.primary)
                    .font(.system(size: 60))
                
                TextField("Amount", text: $checkAmount)
                    .foregroundStyle(.primary)
                    .font(.system(size: 60))
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
            TitleView(title: "SPLIT BY:")
            GuestCountView(guestCount: $numberOfPeople)
        }
        .padding()
    }
}

#Preview {
    MainView()
}

struct TitleView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
        }
    }
}
