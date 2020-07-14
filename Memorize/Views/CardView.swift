//
//  CardView.swift
//  Memorize
//
//  Created by Eugene Kurapov on 14.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card
    var gradient: Gradient?
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }.aspectRatio(3/4, contentMode: .fit)
    }
    
    @State private var animatedBonusRamaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRamaining = card.bonusPartRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRamaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if (card.isFaceUp || !card.isMatched) {
            ZStack {
                Group {
                if card.isConsumingBonus {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: -animatedBonusRamaining*360-90))
                            .onAppear() {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: -card.bonusPartRemaining*360-90))
                    }
                }
                .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: min(size.height, size.width) * fontScaleFactor))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear.repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, with: gradient)
            .transition(.scale)
        }
    }
    
    // MARK: - Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.65
    
}

