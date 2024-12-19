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
        HStack(spacing: 20) {
            Button {
                if guestCount > 1 {
                    guestCount -= 1
                }
            } label: {
                Image(systemName: "minus.circle")
//                    .foregroundStyle(.cyan)
                    .font(.system(.title, design: .rounded))
            }
            
            Text("\(guestCount)")
                .foregroundStyle(.primary)
                .font(.system(size: 40, weight: .black, design: .monospaced))
            
            Button {
                guestCount += 1
            } label: {
                Image(systemName: "plus.circle")
//                    .foregroundStyle(.cyan)
                    .font(.system(.title, design: .rounded))
            }
        }
    }
}

#Preview {
    GuestCountView(guestCount: .constant(1))
}
