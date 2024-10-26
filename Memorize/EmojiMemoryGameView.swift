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
            cards

            Spacer()

            HStack {
                cardAdder
                Spacer()
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                Spacer()
                cardRemover
            }
            .imageScale(.large)
            .font(.largeTitle)

        }
        .padding()
    }
    
    private let cardAspectRatio: CGFloat = 2/3
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: cardAspectRatio) { card in
            VStack {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(Color.orange)
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
