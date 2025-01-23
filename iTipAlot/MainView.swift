//
//  MainView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/17/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var viewModel = MainViewModel()
    @FocusState private var customTipFocused: Bool
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CardView(cardLabelText: "PER PERSON", totalAmount: viewModel.totalPerPerson, subtotalAmount: viewModel.subTotalPerPerson, tipAmount: viewModel.tipValuePerPerson)
                    
                    CardView(cardLabelText: "TOTAL", totalAmount: viewModel.totalAmountWithTip, subtotalAmount: viewModel.subTotal, tipAmount: viewModel.tipValue)
                    
                    TipOptionPickerView(tipOption: $viewModel.tipOption)
                    
                    TipSelectionView(viewModel: $viewModel, customTipFocused: _customTipFocused)
                        .pickerStyle(.segmented)
                        .padding(.bottom)
                                        
                    Section(header: TitleView(title: "CHECK AMOUNT:")) {
                        AmountView(viewModel: $viewModel, amountIsFocused: _amountIsFocused)
                    }
                    
                    Section(header: TitleView(title: "SPLIT BY:")) {
                        GuestCountView(guestCount: $viewModel.numberOfPeople)
                    }
                }
                .navigationTitle("We Like To Tip")
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .background(Image("dollar").opacity(0.2))
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            dismissKeyboard()
                        }
                    }
                }
            }
        }
    }
    
    private func dismissKeyboard() {
        if customTipFocused {
            customTipFocused = false
        } else if amountIsFocused {
            amountIsFocused = false
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
