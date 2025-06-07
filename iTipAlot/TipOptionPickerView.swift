//
//  TipOptionPickerView.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/23/25.
//

import SwiftUI

struct TipOptionPickerView: View {
    
    @Binding var tipOption: TipOption
    
    var body: some View {
        Picker("Tip Option", selection: $tipOption) {
            Text("Percentage").tag(TipOption.percentage)
            Text("Custom Tip").tag(TipOption.customAmount)
        }
        .pickerStyle(.segmented)
        .padding(.bottom)
    }
}

#Preview {
    @Previewable @State var tipOption: TipOption = .percentage
    TipOptionPickerView(tipOption: $tipOption)
}
