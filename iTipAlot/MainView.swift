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
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                if isLoading {
                    LoadingView(isLoading: $isLoading, currencyCode: viewModel.currencyCode)
                        .transition(.opacity)
                } else {
                    
                    if sizeClass == .regular {
                        
                        HStack(alignment: .top, spacing: 32) {
                            
                            VStack {
                                CardView(displayMode: .perPerson, viewModel: viewModel)
                                CardView(displayMode: .total, viewModel: viewModel)
                                Spacer()
                            }
                            .frame(maxWidth: 400)
                            
                            VStack {
                                TipOptionPickerView(tipOption: $viewModel.tipOption)
                                
                                TipSelectionView(viewModel: $viewModel, customTipFocused: $customTipFocused)
                                    .padding(.bottom)
                                
                                Section {
                                    TextField(
                                        "How much?",
                                        value: $viewModel.checkAmount,
                                        format: .currency(code: viewModel.currencyCode))
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
                        }
                        .padding(30)
                        
                    } else {
                        
                        LazyVStack {
                            CardView(displayMode: .perPerson, viewModel: viewModel)
                            
                            CardView(displayMode: .total, viewModel: viewModel)
                            
                            TipOptionPickerView(tipOption: $viewModel.tipOption)
                            
                            TipSelectionView(viewModel: $viewModel, customTipFocused: $customTipFocused)
                                .padding(.bottom)
                            
                            Section {
                                TextField(
                                    "How much?",
                                    value: $viewModel.checkAmount,
                                    format: .currency(code: viewModel.currencyCode))
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
