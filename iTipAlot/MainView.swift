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
    
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            // TODO: Fix so background does not move
            NavigationStack {
                ScrollView {
                    VStack {
                        if isLoading {
                            LoadingView(isLoading: $isLoading)
                                .transition(.opacity)
                        } else {
                            
                            Group {
                                CardView(cardLabelText: "PER PERSON", totalAmount: viewModel.totalPerPerson, subtotalAmount: viewModel.subTotalPerPerson, tipAmount: viewModel.tipValuePerPerson)
                                
                                CardView(cardLabelText: "TOTAL", totalAmount: viewModel.totalAmountWithTip, subtotalAmount: viewModel.subTotal, tipAmount: viewModel.tipValue)
                                
                                TipOptionPickerView(tipOption: $viewModel.tipOption)
                                
                                TipSelectionView(viewModel: $viewModel, customTipFocused: $customTipFocused)
                                    .padding(.bottom)
                                
                                Section(header: TitleView(title: "CHECK AMOUNT:")) {
                                    AmountView(viewModel: $viewModel, amountIsFocused: $amountIsFocused)
                                }
                                .padding(.bottom)
                                
                                Section(header: TitleView(title: "SPLIT BY:")) {
                                    GuestCountView(guestCount: $viewModel.numberOfPeople)
                                }
                            }
                            .transition(.opacity)
                        }
                    }
                    .navigationTitle("Tip In")
                    .navigationBarTitleDisplayMode(.inline)
                    .padding()
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                dismissKeyboard()
                            }
                        }
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
                .background(Image("dollar").opacity(0.2))
            }
        }
        .animation(.easeInOut(duration: 0.4), value: isLoading)
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
