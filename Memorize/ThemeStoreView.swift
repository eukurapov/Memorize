//
//  ThemeStoreView.swift
//  Memorize
//
//  Created by Eugene Kurapov on 14.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct ThemeStoreView: View {
    
    @ObservedObject var themeStore: ThemeStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themeStore.themes, id: \.name) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(theme: theme)
                        .navigationBarTitle(Text(theme.name), displayMode: .inline)) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .font(.title)
                                .foregroundColor(Color(theme.cardStyle.color))
                            Text("\(theme.numberOfPairs) pair from \(theme.emojis.joined())")
                                .font(.body)
                                .lineLimit(1)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet { self.themeStore.themes.remove(at: index) }
                }
            }
            .navigationBarTitle("Memorize")
            .navigationBarItems(
                leading: Button(
                    action: {},
                    label: { Image(systemName: "plus").imageScale(.large) } ),
                trailing: EditButton())
        }
    }
}























struct ThemeStoreView_Previews: PreviewProvider {
    static var previews: some View {
        let themeStore = ThemeStore()
        return ThemeStoreView(themeStore: themeStore)
    }
}
