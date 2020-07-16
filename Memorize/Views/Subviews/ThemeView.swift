//
//  ThemeView.swift
//  Memorize
//
//  Created by Eugene Kurapov on 16.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

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
