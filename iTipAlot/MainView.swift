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
        
        NavigationStack {
            
            ScrollView {
                
                if isLoading {
                    LoadingView(isLoading: $isLoading)
                        .transition(.opacity)
                } else {
                    LazyVStack {
                        CardView(cardLabelText: "PER PERSON", totalAmount: viewModel.totalPerPerson, subtotalAmount: viewModel.subTotalPerPerson, tipAmount: viewModel.tipValuePerPerson)
                        
                        CardView(cardLabelText: "TOTAL", totalAmount: viewModel.totalAmountWithTip, subtotalAmount: viewModel.subTotal, tipAmount: viewModel.tipValue)
                        
                        TipOptionPickerView(tipOption: $viewModel.tipOption)
                        
                        TipSelectionView(viewModel: $viewModel, customTipFocused: $customTipFocused)
                            .padding(.bottom)
                        
                        Section {
                            TextField(
                                "How much?",
                                value: $viewModel.checkAmount,
                                format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .font(.system(size: 40))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        } header: {
                            LabeledContent("CHECK AMOUNT:", value: "")
                        }
                        .padding(.bottom)
                        
                        Section {
                            GuestCountView(guestCount: $viewModel.numberOfPeople)
                        } header: {
                            LabeledContent("SPLIT BY:", value: "")
                        }
                    }
                    .transition(.opacity)
                    .padding()
                }
            }
            .animation(.easeInOut(duration: 0.4), value: isLoading)
            .scrollBounceBehavior(.basedOnSize)
            .background(Image(.dollar).opacity(0.2))
            .navigationTitle("Tip In")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    LabeledContent("") {
                        Button("Done") { dismissKeyboard() }
                    }
                }
            }
        }
    }
    
    private func dismissKeyboard() {
        customTipFocused = false
        amountIsFocused = false
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
