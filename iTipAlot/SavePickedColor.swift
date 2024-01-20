//
//  SavePickedColor.swift
//  iTipAlot
//
//  Created by Anders Tabell on 1/18/24.
//

import SwiftUI

struct ColorData {
    private var COLOR_KEY = "COLOR_KEY"
    private let userDefault = UserDefaults.standard
    
    func saveColor(color: Color) {
        let color = UIColor(color).cgColor
        
        if let components = color.components {
            userDefault.set(components, forKey: COLOR_KEY)
            print("Color saved!!!")
        }
    }
    
    func loadColor() -> Color {
        guard let array = userDefault.object(forKey: COLOR_KEY) as? [CGFloat] else { return Color.primary }
        
        let color = Color(.sRGB, red: array[0], green: array[1], blue: array[2], opacity: array[3])
        print("Color loaded!")
        return color
                
    }
}

struct SavePickedColor: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SavePickedColor()
}
