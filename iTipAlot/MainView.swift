//
//  ContentView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/17/24.
//

import SwiftUI

struct MainView: View { 
    
    @State private var viewModel = MainViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                CardView(cardLabelText: "PER PERSON", totalAmount: viewModel.totalPerPerson, subtotalAmount: viewModel.subTotalPerPerson, tipAmount: viewModel.tipValuePerPerson)
                    .padding(.bottom)
                
                CardView(cardLabelText: "TOTAL", totalAmount: viewModel.totalAmountWithTip, subtotalAmount: viewModel.subTotal, tipAmount: viewModel.tipValue)
                    .padding(.bottom)
                
                Picker("Tip Percentage", selection: $viewModel.tipPercentage) {
                    ForEach(0..<viewModel.tipPercentages.count, id: \.self) {
                        Text("\(viewModel.tipPercentages[$0])%")
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                /// Title of `AmountView`
                TitleView(title: "CHECK AMOUNT")
                
                /// Content of ``AmountView``
                AmountView(viewModel: $viewModel)
                
                /// Title of `GuestCountView`
                /// - seealso: ``GuestCountView``
                TitleView(title: "SPLIT BY:")
                
                GuestCountView(guestCount: $viewModel.numberOfPeople)
            }
            .padding()
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

