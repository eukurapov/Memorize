//
//  GradientPicker.swift
//  Memorize
//
//  Created by Eugene Kurapov on 16.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct GradientPicker: View {
    
    @Binding var gradientColors: [UIColor]?
    
    private var gradients: [[UIColor]] {
        [
            [],
            [.purple, .orange],
            [.blue, .purple],
            [.systemPink, .yellow],
            [.green, .blue],
            [.yellow, .red, .magenta]
        ]
    }
    
    var body: some View {
        Group {
            Grid(gradients, id: \.self) { gradient in
                self.rectangle(with: gradient)
                    .overlay(self.checkMark(when: self.gradientColors == gradient || (self.gradientColors == nil && gradient.isEmpty) ))
                .padding(5)
                .onTapGesture {
                    if gradient.isEmpty {
                        self.gradientColors = nil
                    } else {
                        self.gradientColors = gradient
                    }
                }
            }
            .frame(height: 70)
        }
    }
    
    func rectangle(with gradient: [UIColor]) -> some View {
        Group {
            if gradient.isEmpty {
                RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1)

            } else {
                RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(gradient: Gradient(colors: gradient.map { Color($0) }), startPoint: .topLeading, endPoint: .bottomTrailing))
            }
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
