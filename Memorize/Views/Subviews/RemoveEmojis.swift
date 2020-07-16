//
//  RemoveEmojis.swift
//  Memorize
//
//  Created by Eugene Kurapov on 16.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct RemoveEmojis: View {
    
    @Binding var themeEmojis: [String]
    
    @State var showMinCountAlert: Bool = false
    
    var body: some View {
        Grid(themeEmojis, id: \.self) { emoji in
            Text(emoji).font(Font.system(size: self.fontSize))
                .onTapGesture(count: 2) {
                    if self.themeEmojis.count > 2 {
                        self.themeEmojis.removeAll(where: { $0 == emoji } )
                    } else {
                        self.showMinCountAlert = true
                    }
            }
        }
        .frame(height: self.height)
        .alert(isPresented: $showMinCountAlert, content: {
            Alert(title: Text("Minimum emoji amount"),
                  message: Text("Please leave at least 2 emojis to play the game"),
                  dismissButton: .default(Text("OK"))
            )
        })
    }
    
    var height: CGFloat {
        CGFloat((themeEmojis.count - 1) / 6) * 70 + 70
    }
    let fontSize: CGFloat = 40
    
}
