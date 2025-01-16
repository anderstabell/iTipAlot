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
            HStack{
                Text("Subtotal:")
                Spacer()
                Text(String(format: "$%.2f", subtotalAmount))
            }
            HStack{
                Text("Tip:")
                Spacer()
                Text(String(format: "$%.2f", tipAmount))
            }
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
            
            HStack{
                Text("Total:")
                    .bold()
                Spacer()
                Text(String(format: "$%.2f", totalAmount))
                    .bold()
            }
        }
        .backgroundStyle(.gray.opacity(0.3))
    }
}

#Preview {
    CardView(cardLabelText: "Per Person")
}
