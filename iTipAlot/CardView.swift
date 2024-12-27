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
        VStack(alignment: .leading) {
            
            /// Card label text above the `RoundedRectangle` (Per Person)
            ///- seealso: ``MainView``
            Text(cardLabelText)
                .fontWeight(.black)
            
            // Background for the card
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.gray).opacity(0.5)
                
                // Content of the card
                contentLayer
            }
        }
    }
    
    var contentLayer: some View {
        HStack {
            Spacer()
            
            /// Text for the `totalAmount`
            Text("$ \(totalAmount, specifier: "%.2f")")
                .fontWeight(.bold)
                .font(.system(size: 40))
            
            Spacer()
            
            /// The divider between the `totalAmount` and `subTotal / tip`
            Rectangle()
                .frame(width: 1, height: 90)
            
            Spacer()
            
            /// This will show the `Subtotal` and `Tip`
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("Subtotal")
                        .fontWeight(.bold)
                    
                    Text("$ \(subtotalAmount, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
                
                VStack(alignment: .leading) {
                    Text("Tip")
                        .fontWeight(.bold)
                    
                    Text("$ \(tipAmount, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    CardView(cardLabelText: "Per Person")
        .frame(width: 350, height: 150)
}
