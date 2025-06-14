//
//  CardView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import SwiftUI

struct CardView: View {
    
    let displayMode: CardDisplayMode
    let viewModel: MainViewModel
    
    private var displayValues: (subtotal: Double, tip: Double, total: Double) {
        switch displayMode {
        case .perPerson:
            return (
                subtotal: viewModel.subTotalPerPerson,
                tip: viewModel.tipValuePerPerson,
                total: viewModel.totalPerPerson
            )
        case .total:
            return (
                subtotal: viewModel.subTotal,
                tip: viewModel.tipValue,
                total: viewModel.totalAmountWithTip
            )
        }
    }
    
    var body: some View {
        
        let values = displayValues
        
        GroupBox(displayMode.labelText) {
            LabeledContent(
                "Subtotal",
                value: values.subtotal.formatted(.currency(code: viewModel.currencyCode)))
            
            LabeledContent(
                "Tip",
                value: values.tip.formatted(.currency(code: viewModel.currencyCode)))
            
            Divider()
                .overlay(Color.primary)
            
            LabeledContent(
                "Total",
                value: values.total.formatted(.currency(code: viewModel.currencyCode)))
        }
        .padding(.bottom)
        .foregroundStyle(.primary)
        .backgroundStyle(.gray.opacity(0.3))
    }
}

#Preview {
    let previewViewModel = MainViewModel()
    return CardView(displayMode: .perPerson, viewModel: previewViewModel)
}
