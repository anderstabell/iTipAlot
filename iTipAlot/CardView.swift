//
//  CardView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import SwiftUI

struct CardView: View {
    
    /// Properties for the card label
    var cardLabelText = ""
    var totalAmount = 0.0
    var subtotalAmount = 0.0
    var tipAmount = 0.0
    
    var body: some View {
        
        GroupBox(cardLabelText) {
            LabeledContent(
                "Subtotal",
                value: subtotalAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
            
            LabeledContent(
                "Tip",
                value: tipAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
            
            Divider()
                .overlay(Color.primary)
            
            LabeledContent(
                "Total",
                value: totalAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
        }
        .foregroundStyle(.primary)
        .backgroundStyle(.gray.opacity(0.3))
    }
}

#Preview {
    CardView(cardLabelText: "Per Person")
}
