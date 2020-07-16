//
//  ColorPicker.swift
//  Memorize
//
//  Created by Eugene Kurapov on 16.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct ColorPicker: View {
    
    @Binding var color: UIColor
    
    private var colors: [UIColor] {
        [.orange, .blue, .green, .yellow, .red, .systemPink, .purple, .cyan, .magenta]
    }
    
    var body: some View {
        Group {
            Grid(colors, id: \.self) { color in
                RoundedRectangle(cornerRadius: 5)
                .fill()
                .foregroundColor(Color(color))
                    .overlay(self.checkMark(when: self.color == color))
                .padding(5)
                .onTapGesture {
                    self.color = color
                }
            }
            .frame(height: 140)
        }
    }
    
    func checkMark(when selected: Bool) -> some View {
        Group {
            if selected {
                Image(systemName: "checkmark").imageScale(.large)
            }
        }
    }
    
}
