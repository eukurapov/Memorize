//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Eugene Kurapov on 15.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct ThemeEditor: View {
    
    var theme: Theme
    @Binding var isShowing: Bool
    
    @State private var themeName = ""
    @State private var themeEmojis = [String]()
    @State private var themeColor: UIColor = .white
    @State private var themeGradientColors: [UIColor]?
    
    @EnvironmentObject var themeStore: ThemeStore
    
    var body: some View {
        VStack {
            ZStack {
                Text(theme.name).font(.headline).padding()
                HStack {
                    Button(action: {
                        self.isShowing = false
                    }, label: { Text("Cancel") } )
                    Spacer()
                    Button(action: {
                        self.updateTheme()
                        self.isShowing = false
                    }, label: { Text("Done") } )
                }
                .padding()
            }
            Form {
                TextField("Theme Name", text: $themeName)
                Section(header: Text("Add Emoji").font(.headline)) {
                    AddEmoji(themeEmojis: $themeEmojis)
                }
                Section(header: Text("Emojis").font(.headline),
                        footer: Text("Double tap an emoji to remove it from the theme").font(.caption)) {
                            RemoveEmojis(themeEmojis: self.$themeEmojis)
                }
                Section(header: Text("Color")) {
                    ColorPicker(color: self.$themeColor)
                }
                Section(header: Text("Cover Gradient")) {
                    GradientPicker(gradientColors: self.$themeGradientColors)
                }
            }
        }
        .onAppear {
            self.themeName = self.theme.name
            self.themeEmojis = self.theme.emojis
            self.themeColor = self.theme.cardStyle.color
            self.themeGradientColors = self.theme.cardStyle.gradientColors
        }
    }
    
    private func updateTheme() {
        if let index = self.themeStore.themes.firstIndex(where: { $0.name == self.theme.name }) {
            self.themeStore.themes[index].name = self.themeName
            self.themeStore.themes[index].emojis = self.themeEmojis
            self.themeStore.themes[index].cardStyle.color = self.themeColor
            self.themeStore.themes[index].cardStyle.gradientColors = self.themeGradientColors
        }
    }
}

struct AddEmoji: View {
    
    @Binding var themeEmojis: [String]
    @State private var emojisToAdd = ""
    
    var body: some View {
        ZStack (alignment: .trailing) {
            TextField("Emojis to add", text: $emojisToAdd)
            Button(action: {
                self.emojisToAdd.map { String($0) }.forEach { emoji in
                    if !self.themeEmojis.contains(emoji) {
                        self.themeEmojis.append(emoji)
                    }
                }
                self.emojisToAdd = ""
            },
                   label: { Text("Add") }
            )
        }
    }
    
}

struct RemoveEmojis: View {
    
    @Binding var themeEmojis: [String]
    
    var body: some View {
        Grid(themeEmojis, id: \.self) { emoji in
            Text(emoji).font(Font.system(size: self.fontSize))
                .onTapGesture(count: 2) {
                    self.themeEmojis.removeAll(where: { $0 == emoji } )
            }
        }
        .frame(height: self.height)
    }
    
    var height: CGFloat {
        CGFloat((themeEmojis.count - 1) / 6) * 70 + 70
    }
    let fontSize: CGFloat = 40
    
}

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
