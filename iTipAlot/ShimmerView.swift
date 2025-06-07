//
//  ShimmerView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 5/3/25.
//

import SwiftUI

struct ShimmerView: View {
    var body: some View {
        VStack {
            
            TextShimmerView(text: "Warming up the calculator...")
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .preferredColorScheme(.dark)
    }
}


#Preview {
    ShimmerView()
}

