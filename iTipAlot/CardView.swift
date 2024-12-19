//
//  CardView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import SwiftUI

struct CardView: View {
    
    var cardLabelText = ""
    var totalAmount = 0.0
    var subtotalAmount = 0.0
    var tipAmount = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(cardLabelText)
//                .foregroundStyle(.cyan)
                .fontWeight(.black)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.gray)
                
                HStack {
                    Spacer()
                    
                    Text("$ \(totalAmount, specifier: "%.2f")")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(width: 1, height: 90)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading) {
                            Text("Subtotal")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            
                            Text("$ \(subtotalAmount, specifier: "%.2f")")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Tip")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            
                            Text("$ \(tipAmount, specifier: "%.2f")")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CardView()
}
