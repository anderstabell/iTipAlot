//
//  ContentView.swift
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
                        .padding(.bottom)

                    CardView(cardLabelText: "TOTAL", totalAmount: viewModel.totalAmountWithTip, subtotalAmount: viewModel.subTotal, tipAmount: viewModel.tipValue)
                        .padding(.bottom)

                    Picker("Tip Option", selection: $viewModel.tipOption) {
                        Text("Percentage").tag(TipOption.percentage)
                        Text("Custom $ Tip").tag(TipOption.customAmount)
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom)

                    if viewModel.tipOption == .percentage {
                        Slider(value: $viewModel.tipPercentage, in: 0...100, step: 1)
                            .tint(.secondary)
                        Text("Tip Percentage: \(Int(viewModel.tipPercentage))%")
                            .padding(.bottom)
                    } else {
                        HStack {
                            Image(systemName: "dollarsign")
                                .foregroundStyle(.primary)
                                .font(.system(size: 30))
                                .bold()
                            TextField("Custom Tip Amount", value: $viewModel.customTipAmount, format: .number)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                                .opacity(0.5)
                                .focused($customTipFocused)
                                .onSubmit {
                                    customTipFocused = false
                                }
                        }
                        .padding(.bottom)
                    }


                    /// Title of `AmountView`
                    TitleView(title: "CHECK AMOUNT")

                    /// Content of ``AmountView``
                    AmountView(viewModel: $viewModel, amountIsFocused: _amountIsFocused)

                    /// Title of `GuestCountView`
                    TitleView(title: "SPLIT BY:")

                    GuestCountView(guestCount: $viewModel.numberOfPeople)
                }
                .navigationTitle("We Like To Tip")
                .padding()
                .background(Image("dollar").opacity(0.2))
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            if customTipFocused {
                                customTipFocused = false
                            } else if amountIsFocused {
                                amountIsFocused = false
                            }
                        }
                    }
                }
            }
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
