//
//  LoadingView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 4/27/25.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var isLoading: Bool
    
    let currencyCode: String
    
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var rotationAngle: Double = 0.0
    
    let loadingDuration: Double = 3.0
    let timerInterval: Double = 0.05
    let rotationSpeed: Double = 4.0
    
    private var imageName: String {
        return iconName(for: currencyCode)
    }
    
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
            
            TextShimmerView(text: "Warming up the calculator...")
            
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
    
    private func iconName(for currencyCode: String) -> String {
        switch currencyCode.uppercased() {
            
        case "USD", "CAD": // US, Canadian Dollars
            return "dollarsign.circle.fill"
        case "AUD": // Australian Dollar
            return "australiandollarsign.circle.fill"
        case "EUR": // Euro
            return "eurosign.circle.fill"
        case "GBP": // British Pound
            return "sterlingsign.circle.fill"
        case "JPY", "CNY": // Japanese Yen, Chinese Yuan
            return "yensign.circle.fill"
        case "INR": // Indian Rupee
            return "indianrupeesign.circle.fill"
        case "BRL": // Brazilian Real
            return "brazilianrealsign.circle.fill"
        case "KRW": // South Korean Won
            return "wonsign.circle.fill"
        case "RUB": // Russian Ruble
            return "rublesign.circle.fill"
        case "TRY": // Turkish Lira
            return "turkishlirasign.circle.fill"
        case "NOK": // Norwegian Krone
            return "norwegiankronesign.circle.fill"
        case "ILS": // Israeli Shekel
            return "shekelsign.circle.fill"
        case "UAH": // Ukrainian Hryvnia
            return "hryvniasign.circle.fill"
        case "KZT": // Kazakhstani Tenge
            return "tengesign.circle.fill"
        case "GEL": // Georgian Lari
            return "larisign.circle.fill"
        case "NGN": // Nigerian Naira
            return "nairasign.circle.fill"
        case "MNT": // Mongolian Tugrik
            return "tugriksign.circle.fill"
        case "BDT": // Bangladeshi Taka
            return "takasign.circle.fill"
        case "CRC": // Costa Rican Colon
            return "coloncurrencysign.circle.fill"
        case "PYG": // Paraguayan Guarani
            return "guaranisign.circle.fill"
        case "PHP": // Philippine Peso
            return "pesosign.circle.fill"
        case "VND": // Vietnamese Dong
            return "dongsign.circle.fill"
        case "THB": // Thai Baht
            return "bahtsign.circle.fill"
        case "CHF": // Swiss Franc
            return "francsign.circle.fill"
        case "GHS": // Ghanaian Cedi
            return "cedisign.circle.fill"
        case "LAK": // Lao Kip
            return "kipsign.circle.fill"
        case "AZN": // Azerbaijani Manat
            return "manatsign.circle.fill"
        default:
            return "creditcard.circle.fill"
        }
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
    
    @Previewable @State var isLoading = true
    
    ZStack {
        if isLoading {
            
            LoadingView(isLoading: $isLoading, currencyCode: "USD")
                .preferredColorScheme(.dark)
                .transition(.opacity)
            
        } else {
            Text("Loading Complete!")
                .font(.largeTitle)
                .preferredColorScheme(.dark)
        }
    }
}
