//
//  ContentView.swift
//  iTipAlotWatch Watch App
//
//  Created by Anders Tabell on 1/7/25.
//

import SwiftUI

struct ContentView: View {
    
    let connectivity = watchOSConnectivity.shared
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
