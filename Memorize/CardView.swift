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
        Pie(endAngle: .degrees(120))
            .opacity(Constants.Pie.opacity)
            .overlay {
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            }
            .padding(Constants.inset)
            // 自定義的 ViewModifier
            .modifier(Cardify(isFaceUp: card.isFaceUp)) // 或 .cardify(isFaceUp:)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
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
