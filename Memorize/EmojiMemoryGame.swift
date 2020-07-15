//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Evgeniy Kurapov on 22.05.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

// MARK: - This is View Model

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>!
    private var theme: Theme!
    private var hidingTimer: Timer?
    
    init(with theme: Theme? = nil) {
        newGame(with: theme)
    }
    
    static func createMemoryGame(for theme: Theme) -> MemoryGame<String> {
        var emojis = theme.emojis
        emojis.shuffle()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    private func restartTimer() {
        hidingTimer?.invalidate()
        var interval = 0.5
        // longer timer for case when only one card is selected
        if let _ = model.cards.filter({ $0.isFaceUp }).only {
            interval = 3.5
        }
        hidingTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in self.model.hideAll() }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    var cardColor: Color { return Color(theme.cardStyle.color) }
    var cardGradient: Gradient? {
        if let gradientColors = theme.cardStyle.gradientColors {
            return Gradient(colors: gradientColors.map { Color($0) } )
        }
        return nil
    }
    var themeName: String { return theme.name }
    var score: Int { return model.score }
    
    // MARK: - Intent(s)
    
    func newGame(with theme: Theme? = nil) {
        self.theme = theme ?? .any
        self.model = EmojiMemoryGame.createMemoryGame(for: self.theme)
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
        //restartTimer()
    }
    
}
