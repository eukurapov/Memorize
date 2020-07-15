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
    
    @State private var showEditor: Bool = false
    @State private var editMode: EditMode = .inactive
    @State private var themeToEdit: Theme?
    
    // fix for Navigaitionview being disabled after editor is closed by buttons Cancel or Done
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themeStore.themes, id: \.name) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(theme: theme)
                        .navigationBarTitle(Text(theme.name), displayMode: .inline)) {
                            ThemeView(theme: theme,
                                      editMode: self.$editMode,
                                      themeToEdit: self.$themeToEdit,
                                      showEditor: self.$showEditor)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet { self.themeStore.themes.remove(at: index) }
                }
            }
            .navigationBarTitle("Memorize")
            .navigationBarItems(
                leading: Button(
                    action: { print("Add") },
                    label: { Image(systemName: "plus").imageScale(.large) } ),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $showEditor) {
                ThemeEditor(theme: self.themeToEdit!, isShowing: self.$showEditor)
                    .environmentObject(self.themeStore)
                    .onDisappear {
                        self.themeToEdit = .none
                }
            }
        }
    }
}

struct ThemeView: View {
    
    var theme: Theme
    @Binding var editMode: EditMode
    @Binding var themeToEdit: Theme?
    @Binding var showEditor: Bool
    
    var body: some View {
        HStack {
            if self.editMode == EditMode.active {
                Image(systemName: "slider.horizontal.3")
                    .imageScale(.large)
                    .onTapGesture {
                        self.themeToEdit = self.theme
                        self.showEditor = true
                }
            }
            VStack(alignment: .leading) {
                Text(theme.name)
                    .font(.title)
                    .foregroundColor(Color(theme.cardStyle.color))
                Text("\(theme.numberOfPairs) pairs from \(theme.emojis.joined())")
                    .font(.body)
                    .lineLimit(1)
            }
        }
    }
    
}























struct ThemeStoreView_Previews: PreviewProvider {
    static var previews: some View {
        let themeStore = ThemeStore()
        return ThemeStoreView(themeStore: themeStore)
    }
}
