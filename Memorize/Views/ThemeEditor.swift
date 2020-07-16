//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Eugene Kurapov on 15.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct ThemeEditor: View {
    
    @State var theme: Theme
    @Binding var isShowing: Bool
    
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
                TextField("Theme Name", text: $theme.name)
                Section(header: Text("Add Emoji").font(.headline)) {
                    AddEmoji(themeEmojis: $theme.emojis)
                }
                Section(header: Text("Emojis").font(.headline),
                        footer: Text("Double tap an emoji to remove it from the theme").font(.caption)) {
                            RemoveEmojis(themeEmojis: self.$theme.emojis)
                }
                Section(header: Text("Number of pairs").font(.headline)) {
                    NumberPicker(number: self.$theme.numberOfPairs, max: self.theme.emojis.count)
                }
                Section(header: Text("Color").font(.headline)) {
                    ColorPicker(color: self.$theme.cardStyle.color)
                }
                Section(header: Text("Cover Gradient").font(.headline)) {
                    GradientPicker(gradientColors: self.$theme.cardStyle.gradientColors)
                }
            }
        }
    }
    
    private func updateTheme() {
        if let index = self.themeStore.themes.firstIndexOf(self.theme) {
            self.themeStore.themes[index] = self.theme
        } else {
            self.themeStore.themes.append(self.theme)
        }
    }
}
