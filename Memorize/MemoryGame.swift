//
//  MemorizeGame.swift
//  Memorize
//
//  Created by usr on 2024/9/8.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    /* Card 須遵從 Equatable 並實作 func ==(lhs:rhs:)
     * 當 ==(lhs:rhs:) 是逐條比對物件屬性，可以省略不寫（Swift 會默認進行比對）*/
    /* Card 須遵從 Identifiable 增加一屬性 "id" */
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent

        var id: String

        var debugDescription: String {
            "\(content)"
        }
    }
    
    private(set) var cards: [Card]
    
    /* Getter & Setter 計算屬性 */
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            // funcational programming
            let faceUpIndices = cards.indices.filter { index in cards[index].isFaceUp }
            return faceUpIndices.count == 1 ? faceUpIndices.first : nil
            
            //原式
            //var faceUpIndices: [Int] = []
            //for index in cards.indices {
            //    if cards[index].isFaceUp {
            //        faceUpIndices.append(index)
            //    }
            //}
            //if faceUpIndices.count == 1 {
            //    return faceUpIndices.first
            //} else {
            //    return nil
            //}
        }

        set {
            // funcational programming
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
            
            //原式
            //for index in cards.indices {
            //    if index == newValue {
            //        cards[index].isFaceUp = true
            //    } else {
            //        cards[index].isFaceUp = false
            //    }
            //}
        }
    }
    
    
    // cardContentFactory知道 CardContent 是什麼，而 MemoryGame 並不知道
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        
        // max(2, …) 避免輸入0的例子
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    /* mutating function：此函式中會修改 cards 的數值 */
    mutating func choose(_ card: Card) {
        print("chose: \(card)")
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
}

extension Array {
    var only: Element? {
        self.count == 1 ? self.first : nil
    }
}
