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
                guard guestCount > 1 else { return }
                guestCount -= 1
            } label: {
                Image(systemName: "arrow.left.circle")
            }
            
            Text(guestCount.formatted())
                .font(.system(size: 40, weight: .black, design: .monospaced))
                .padding(.horizontal)
                .contentTransition(.numericText(value: Double(guestCount)))
            
            Button {
                guestCount += 1
            } label: {
                Image(systemName: "arrow.right.circle")
            }
        }
        .animation(.default, value: guestCount)
        .font(.system(.title, design: .rounded, weight: .bold))
        .foregroundStyle(.white)
        .buttonRepeatBehavior(.enabled)
    }
}

#Preview {
    @Previewable @State var guestCount = 1
    GuestCountView(guestCount: $guestCount)
        .preferredColorScheme(.dark)
}
