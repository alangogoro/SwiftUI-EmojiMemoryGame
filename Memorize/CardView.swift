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
        
        // Functional Programming 將函式作為參數傳遞
        // 比如下VStack的 content 參數
        ZStack(content: {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill().foregroundColor(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Text(card.content)
                    .font(.system(size: 200))
                    // 限定字體因寬高限制而縮小的最小比率，此處為 1/100
                    .minimumScaleFactor(0.01)
                    // 設定 Text 的 寬&高比例是正方形 (1:1)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.inset)
                    .multilineTextAlignment(.center)
            }
            // opacity 透明度
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        })
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        /* 點擊 ZStack 時觸發
         .onTapGesture(perform: {
         card.isFaceUp.toggle()
         }) */
        
    }
    
    // MARK: 常數
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
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
