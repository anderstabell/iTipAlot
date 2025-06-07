//
//  TextShimmerView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 6/7/25.
//

import SwiftUI

struct TextShimmerView: View {
    
    var text: String
    @State private var startAnimationTrigger = false
    
    let baseTextColor: Color = .green.opacity(0.5)
    let shimmerColor: Color = .white
    let gradientWidth: CGFloat = 150
    let animationDuration: Double = 4.0
    
    var body: some View {
        ZStack {
            
            Text(text)
                .font(.system(size: 30))
                .foregroundStyle(baseTextColor)
            
            Text(text)
                .font(.system(size: 30))
                .foregroundStyle(shimmerColor)
                .mask(
                    
                    GeometryReader { geo in
                        let textWidth = geo.size.width
                        let startX = -gradientWidth
                        let endX = textWidth + gradientWidth
                        
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .clear,
                                shimmerColor.opacity(0.9),
                                .clear
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: gradientWidth)
                        .offset(x: startAnimationTrigger ? endX : startX)
                        
                    }
                )
        }
        .phaseAnimator([false, true], trigger: startAnimationTrigger) { content, phase in
            content
        } animation: { phase in
                .linear(duration: animationDuration)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                startAnimationTrigger.toggle()
            }
        }
    }
}

#Preview {
    TextShimmerView(text: "Nice shimmer, buddy!")
        .preferredColorScheme(.dark)
}
