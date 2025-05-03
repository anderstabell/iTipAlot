//
//  LoadingView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 4/27/25.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var isLoading: Bool
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var rotationAngle: Double = 0.0
        
    let loadingDuration: Double = 3.0
    let timerInterval: Double = 0.05
    let rotationSpeed: Double = 4.0
    
    let imageName = "dollarsign.circle.fill"
    
    var body: some View {
        
        VStack(spacing: 32) {
            
            Spacer()
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 256, height: 256)
                .foregroundColor(.green)
                .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0.0, y: 1.0, z: 1.0))
                .onAppear {
                    withAnimation(.linear(duration: rotationSpeed).repeatForever(autoreverses: false)) {
                        rotationAngle = 360.0
                    }
                }
            
            Text("Warming up the calculator...")
                .font(.title2).foregroundColor(.secondary)
            
            VStack {
                Text("\(Int(min(max(progress, 0.0), 1.0) * 100))%")
                    .font(.title3)
                    .foregroundStyle(.green)
                
                ProgressView(value: min(max(progress, 0.0), 1.0), total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .green))
                    .padding(.horizontal, 50)
                    .shadow(color: .gray.opacity(0.3), radius: 3, y: 3)
            }
            
            Spacer()
        }
        .onAppear(perform: startLoadingSimulation)
        .onDisappear(perform: stopTimer)
    }
    
    func startLoadingSimulation() {
        stopTimer()
        progress = 0.0
        let increment = timerInterval / loadingDuration
        
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { _ in
            withAnimation(.linear(duration: timerInterval)) {
                progress += increment
            }
            
            if progress >= 1.0 {
                stopTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    LoadingView(isLoading: .constant(true))
}
