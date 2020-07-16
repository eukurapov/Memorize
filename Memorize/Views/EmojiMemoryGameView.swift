//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Evgeniy Kurapov on 22.05.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    var theme: Theme
    @ObservedObject private var emojiMemoryGame: EmojiMemoryGame
    
    init(theme: Theme) {
        self.theme = theme
        self.emojiMemoryGame = EmojiMemoryGame(with: theme)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("New Game",
                       action: { withAnimation(.easeInOut) { self.emojiMemoryGame.newGame(with: self.theme) } }
                )
                Spacer()
                Text("Score: \(self.emojiMemoryGame.score)")
                    .animation(.none)
            }
            .padding()
            Grid (emojiMemoryGame.cards) { card in
                CardView(card: card, gradient: self.emojiMemoryGame.cardGradient).onTapGesture {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        self.emojiMemoryGame.choose(card: card)
                    }
                }                
                .padding(5)
            }
            .foregroundColor(self.emojiMemoryGame.cardColor)
        }
    }
}






















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let theme = Theme.defaults.randomElement()
        return EmojiMemoryGameView(theme: theme!)
    }
}
