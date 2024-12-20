//
//  ContentView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/17/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var vm = MainViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            CardView(cardLabelText: "PER PERSON", totalAmount: vm.totalPerPerson, subtotalAmount: vm.subTotalPerPerson, tipAmount: vm.tipValuePerPerson)
                .frame(maxWidth: .infinity)
            
            CardView(cardLabelText: "TOTAL", totalAmount: vm.totalAmountWithTip, subtotalAmount: vm.subTotal, tipAmount: vm.tipValue)
                .frame(maxWidth: .infinity)
            
            Picker("Tip Percentage", selection: $vm.tipPercentage) {
                ForEach(0..<vm.tipPercentages.count, id: \.self) {
                    Text("\(vm.tipPercentages[$0])%")
                }
            }
            .pickerStyle(.segmented)
            
            /// Title of `AmountView`
            TitleView(title: "BILL AMOUNT")
            
            /// Content of `AmountView`
            AmountView(vm: $vm)
            
            /// Title of `GuestCountView`
            /// - seealso: ``GuestCountView``
            TitleView(title: "SPLIT BY:")
            GuestCountView(guestCount: $vm.numberOfPeople)
        }
        .background(Image("dollar").opacity(0.2))
        .padding()
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
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
