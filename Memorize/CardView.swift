//
//  CardView.swift
//  Memorize
//
//  Created by usr on 2024/10/26.
//

import SwiftUI

// MARK: 卡片視圖
struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    var body: some View {
        TimelineView(.animation) { timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay {
                        cardContents.padding(Constants.Pie.inset)
                    }
                    .padding(Constants.inset)
                // 自定義的 ViewModifier Cardify
                    .modifier(Cardify(isFaceUp: card.isFaceUp)) // 或 .cardify(isFaceUp:)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
        
        // 在卡片配對成功(isMatched)時，啟用旋轉動畫
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1),
                       value: card.isMatched)
    }
    
    // MARK: 常數
    private struct Constants {
        static let inset: CGFloat = 5

        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }

        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
}



struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View {
        HStack {
            CardView(card: Card(isFaceUp: true,
                                content: "♠️", id: "test1"))
            .aspectRatio(2/3, contentMode: .fit)
            CardView(card: Card(isFaceUp: false,
                                content: "♦️", id: "test2"))
            .aspectRatio(3/4, contentMode: .fit)
        }
        .padding()
    }
}

// MARK: - Animation
extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration)
        // 永遠重複動畫
        .repeatForever(autoreverses: false)
    }
}
