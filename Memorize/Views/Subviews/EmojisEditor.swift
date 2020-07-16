//
//  RemoveEmojis.swift
//  Memorize
//
//  Created by Eugene Kurapov on 16.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct EmojisEditor: View {
    
    var emojis: [String]
    var action: (String) -> ()
    
    var body: some View {
        Grid(emojis, id: \.self) { emoji in
            Text(emoji).font(Font.system(size: self.fontSize))
                .onTapGesture(count: 2) {
                    self.action(emoji)
            }
        }
        .frame(height: self.height)
    }
    
    var height: CGFloat {
        CGFloat((emojis.count - 1) / 6) * 70 + 70
    }
    let fontSize: CGFloat = 40
    
}
