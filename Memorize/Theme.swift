//
//  Theme.swift
//  Memorize
//
//  Created by Eugene Kurapov on 10.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct Theme: Codable {
    
    static let halloween = Theme(name: "Halloween",
                                 emojis: ["👻", "🎃", "🕷", "🧙‍♀️", "🕯"],
                                 cardStyle: CardStyle(color: .orange),
                                 numberOfPairsOfCards: 4)
    static let sports = Theme(name: "Sports",
                              emojis: ["🏃‍♂️", "⚽️", "🏀", "🎾", "🥋", "🥌", "🏋️", "🥇", "🏓", "🏒"],
                              cardStyle: CardStyle(color: .green, gradientColors: [.green, .blue]),
                              numberOfPairsOfCards: 10)
    static let animals = Theme(name: "Animals",
                               emojis: ["🐶", "🐱", "🐭", "🦊", "🐼", "🐨", "🐷"],
                               cardStyle: CardStyle(color: .systemPink, gradientColors: [.systemPink, .yellow]),
                               numberOfPairsOfCards: 5)
    static let faces = Theme(name: "Faces",
                             emojis: ["😀", "🥰", "🤪", "😎", "🤬", "😱", "🥶", "🤯", "🤢", "🥵", "😘", "🤠"],
                             cardStyle: CardStyle(color: .blue, gradientColors: [.blue, .purple]),
                             numberOfPairsOfCards: 15)
    static let transport = Theme(name: "Transport",
                            emojis: ["🚗", "🚕", "🚜", "🚒", "🏎", "🚑", "🚓"],
                            cardStyle: CardStyle(color: .purple, gradientColors: [.purple, .orange]),
                            numberOfPairsOfCards: 5)
    
    let name: String
    let emojis: [String]
    let cardStyle: CardStyle
    let numberOfPairs: Int
    
    init(name: String, emojis: [String], cardStyle: CardStyle, numberOfPairsOfCards: Int) {
        self.name = name
        self.emojis = emojis
        self.cardStyle = cardStyle
        self.numberOfPairs = max(min(numberOfPairsOfCards, emojis.count), 1)
    }
    
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    init?(from json: Data?) {
        if json != nil, let theme = try? JSONDecoder().decode(Theme.self, from: json!) {
            self = theme
        } else {
            return nil
        }
    }
    
    struct CardStyle: Codable {
        private var _color: UIColor.RGB!
        private var _gradientColors: [UIColor.RGB]?
        
        init(color: UIColor, gradientColors: [UIColor]? = nil) {
            self.color = color
            self.gradientColors = gradientColors
        }
        
        var color: UIColor {
            get { UIColor(_color) }
            set { _color = newValue.rgb }
        }
        
        var gradientColors: [UIColor]? {
            get { _gradientColors?.map { UIColor($0) } }
            set { _gradientColors = newValue?.map { $0.rgb } }
        }
    }
}
