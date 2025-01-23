//
//  GuestCountView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 12/19/24.
//

import SwiftUI

struct GuestCountView: View {
    
    @Binding var guestCount: Int
    
    var body: some View {
        HStack {
            Button {
                if guestCount > 1 {
                    guestCount -= 1
                }
            } label: {
                Image(systemName: "arrow.left.circle")
                    .font(.system(.title, design: .rounded))
                    .foregroundStyle(.white)
                    .bold()
            }
            
            Text("\(guestCount)")
                .font(.system(size: 40, weight: .black, design: .monospaced))
                .padding(.horizontal)
            
            Button {
                guestCount += 1
            } label: {
                Image(systemName: "arrow.right.circle")
                    .font(.system(.title, design: .rounded))
                    .foregroundStyle(.white)
                    .bold()
            }
        }
    }
}

#Preview {
    GuestCountView(guestCount: .constant(1))
        .preferredColorScheme(.dark)
}
