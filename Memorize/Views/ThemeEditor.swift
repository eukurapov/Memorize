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
    @State private var themeNumberOfPairs = 2
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
                Section(header: Text("Number of pairs").font(.headline)) {
                    NumberPicker(number: self.$themeNumberOfPairs, max: self.themeEmojis.count)
                }
                Section(header: Text("Color").font(.headline)) {
                    ColorPicker(color: self.$themeColor)
                }
                Section(header: Text("Cover Gradient").font(.headline)) {
                    GradientPicker(gradientColors: self.$themeGradientColors)
                }
            }
        }
        .onAppear {
            self.themeName = self.theme.name
            self.themeNumberOfPairs = self.theme.numberOfPairs
            self.themeEmojis = self.theme.emojis
            self.themeColor = self.theme.cardStyle.color
            self.themeGradientColors = self.theme.cardStyle.gradientColors
        }
    }
    
    private func updateTheme() {
        if let index = self.themeStore.themes.firstIndex(where: { $0.name == self.theme.name }) {
            self.themeStore.themes[index].name = self.themeName
            self.themeStore.themes[index].numberOfPairs = self.themeNumberOfPairs
            self.themeStore.themes[index].emojis = self.themeEmojis
            self.themeStore.themes[index].cardStyle.color = self.themeColor
            self.themeStore.themes[index].cardStyle.gradientColors = self.themeGradientColors
        } else {
            self.themeStore.themes.append(Theme(name: self.themeName,
                                                emojis: self.themeEmojis,
                                                cardStyle: Theme.CardStyle(color: self.themeColor, gradientColors: self.themeGradientColors),
                                                numberOfPairsOfCards: self.themeNumberOfPairs))
        }
    }
}
