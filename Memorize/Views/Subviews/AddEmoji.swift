//
//  AddEmoji.swift
//  Memorize
//
//  Created by Eugene Kurapov on 16.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct AddEmoji: View {
    
    @Binding var themeEmojis: [String]
    @State private var emojisToAdd = ""
    
    var body: some View {
        HStack {
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
