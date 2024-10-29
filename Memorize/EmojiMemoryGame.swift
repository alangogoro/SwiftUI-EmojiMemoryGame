//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by usr on 2024/9/8.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    // 靜態常數 & 靜態方法
    private static let emojis = ["👻", "🎃", "😈", "💀", "🧙🏻‍♀️", "🕸️", "🗿", "👺", "👽", "😱"]
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(
            numberOfPairsOfCards: 2,
            // cardContentFactory: (Int) -> CardContent
            // 採用 functional programming: 將函式設為 MemoryGame 初始器的一個參數
            cardContentFactory: { pairIndex in
                if emojis.indices.contains(pairIndex) {
                    return emojis[pairIndex]
                } else {
                    return "✖️"
                }
            }
        )
    }
    
    // ⭐️ ObservableObject 中的屬性，可加上 **@Published** property wrapper
    @Published private var model = createMemoryGame()
    
    var cards: [Card] {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}
