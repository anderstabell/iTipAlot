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
        
        NavigationStack {
            ScrollView {
                CardView(cardLabelText: "PER PERSON", totalAmount: vm.totalPerPerson, subtotalAmount: vm.subTotalPerPerson, tipAmount: vm.tipValuePerPerson)
                    .padding(.bottom)
                
                CardView(cardLabelText: "TOTAL", totalAmount: vm.totalAmountWithTip, subtotalAmount: vm.subTotal, tipAmount: vm.tipValue)
                    .padding(.bottom)
                
                Picker("Tip Percentage", selection: $vm.tipPercentage) {
                    ForEach(0..<vm.tipPercentages.count, id: \.self) {
                        Text("\(vm.tipPercentages[$0])%")
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                /// Title of `AmountView`
                TitleView(title: "CHECK AMOUNT")
                
                /// Content of ``AmountView``
                AmountView(vm: $vm)
                
                /// Title of `GuestCountView`
                /// - seealso: ``GuestCountView``
                TitleView(title: "SPLIT BY:")
                
                GuestCountView(guestCount: $vm.numberOfPeople)
            }
            .padding()
            .navigationTitle("We like to tip!")
            .background(Image("dollar").opacity(0.2))
        }
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

