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
    
    private static let themes: [Theme] = [.halloween, .animals, .sports, .transport, .faces]
    
    @Published private var model: MemoryGame<String>!
    private var theme: Theme!
    private var hidingTimer: Timer?
    
    init(with theme: Theme? = nil) {
        newGame(with: theme)
    }
    
    static func createMemoryGame(for theme: Theme) -> MemoryGame<String> {
        var emojis = theme.emojis
        emojis.shuffle()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
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
    var cardColor: Color { return theme.cardStyle.color }
    var cardGradient: Gradient? { return theme.cardStyle.gradient }
    var themeName: String { return theme.name }
    var score: Int { return model.score }
    
    // MARK: - Intent(s)
    
    func newGame(with theme: Theme? = nil) {
        self.theme = theme ?? EmojiMemoryGame.themes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(for: self.theme)
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
        //restartTimer()
    }
    
    struct Theme {
        static let halloween = Theme(name: "Halloween",
                                     emojis: ["👻", "🎃", "🕷", "🧙‍♀️", "🕯"],
                                     cardStyle: CardStyle(color: .orange))
        static let sports = Theme(name: "Sports",
                                  emojis: ["🏃‍♂️", "⚽️", "🏀", "🎾", "🥋", "🥌", "🏋️", "🥇", "🏓", "🏒"],
                                  cardStyle: CardStyle(color: .green, gradient: Gradient(colors: [.green, .blue])),
                                  numberOfPairsOfCards: 10)
        static let animals = Theme(name: "Animals",
                                   emojis: ["🐶", "🐱", "🐭", "🦊", "🐼", "🐨", "🐷"],
                                   cardStyle: CardStyle(color: .pink, gradient: Gradient(colors: [.pink, .yellow])))
        static let faces = Theme(name: "Faces",
                                 emojis: ["😀", "🥰", "🤪", "😎", "🤬", "😱", "🥶", "🤯", "🤢", "🥵", "😘", "🤠"],
                                 cardStyle: CardStyle(color: .blue, gradient: Gradient(colors: [.blue, .purple])))
        static let transport = Theme(name: "Transport",
                                emojis: ["🚗", "🚕", "🚜", "🚒", "🏎", "🚑", "🚓"],
                                cardStyle: CardStyle(color: .purple, gradient: Gradient(colors: [.purple, .orange])),
                                numberOfPairsOfCards: 5)
        
        let name: String
        let emojis: [String]
        let cardStyle: CardStyle
        private var numberOfPairs: Int?
        
        init(name: String, emojis: [String], cardStyle: CardStyle, numberOfPairsOfCards: Int? = nil) {
            self.name = name
            self.emojis = emojis
            self.cardStyle = cardStyle
            if let numberOfPairsOfCards = numberOfPairsOfCards {
                self.numberOfPairsOfCards = numberOfPairsOfCards
            }
        }
        
        private(set) var numberOfPairsOfCards: Int {
            get {
                numberOfPairs ?? Int.random(in: 2...emojis.count)
            }
            set {
                numberOfPairs = min(newValue, emojis.count)
            }
        }
        
        struct CardStyle {
            var color: Color
            var gradient: Gradient?
        }
    }
    
}
