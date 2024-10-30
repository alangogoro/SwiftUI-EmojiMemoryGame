//
//  ContentView.swift
//  Memorize
//
//  Created by usr on 2024/8/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // ObservedObject 一旦發生變化，將重繪 view (EmojiMemoryGameView)
    @ObservedObject var viewModel: EmojiMemoryGame
    @State var cardCount: Int = 3
    
    var body: some View {
        VStack {
            cards.foregroundColor(Color.orange)

            HStack {
                score
                Spacer()
                
                deck.foregroundColor(Color.orange)
                Spacer()

                Button("Shuffle") {
                    withAnimation {
                        viewModel.shuffle()
                    }
                }
            }
            .font(.title)
            .imageScale(.large)
        }
        .padding()
    }
    
    typealias Card = MemoryGame<String>.Card
    private let cardAspectRatio: CGFloat = 2/3
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: cardAspectRatio) { card in
            Group {
                if isDealt(card) {
                    CardView(card: card)
                        .padding(4)
                        .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                        // Z軸的順位，預設為 0，數值愈大愈靠上
                        .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    
                        // 點擊（選牌）
                        .onTapGesture {
                            withAnimation() {
                                let scoreBeforeChoosing = viewModel.score
                                viewModel.choose(card)
                                
                                // 選牌後，通知得分變化
                                let scoreChange = viewModel.score - scoreBeforeChoosing
                                lastScoreChange = (scoreChange, card.id)
                            }
                        }
                    
                        /* 標記卡片的位置於命名空間中，使卡片在移動時保持視覺連續性
                         * 停用卡片出現和消失的過渡效果（淡出入） */
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
            }
        }
    }
    
    // MARK: - Dealing from a Deck
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card: card)
                /* 標記卡片的位置於命名空間中，使卡片在移動時保持視覺連續性
                 * 停用卡片出現和消失的過渡效果（淡出入） */
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / cardAspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private let deckWidth: CGFloat = 50
    
    /// 發牌動畫
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: 1).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += 0.15
        }
    }
    
    /// 得分變化元組
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    /// 得分文字
    var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    /// 加卡片按鈕
    var cardAdder: some View {
        Button {
            cardCount += 1
        } label: {
            Image(systemName: "rectangle.stack.badge.plus.fill")
        }
        // 在…情況下設為禁用
        .disabled(cardCount > viewModel.cards.count - 1)
    }
    
    /// 減卡片按鈕
    var cardRemover: some View {
        Button {
            cardCount -= 1
        } label: {
            Image(systemName: "rectangle.stack.badge.minus.fill")
        }
        // 在…情況下設為禁用
        .disabled(cardCount <= 1)
    }
}



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

