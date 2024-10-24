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
            ScrollView {
                /* LazyGride 會盡可能內縮
                 * GridItem 可以設置欄位大小 */
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],
                          spacing: 0) {
                    /* ForEach View
                     * 參數id：給 ForEach 分辨物件的識別碼（有唯一性） */
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                        // 設定卡片的 寬&高比例
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(4)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                    /* 加入基礎動畫 */
                    .animation(.default, value: viewModel.cards)
                }
                .foregroundColor(.orange)// Modifier
            }

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

// MARK: 卡片視圖
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {

        // Functional Programming 將函式作為參數傳遞
        // 比如下VStack的 content 參數
        ZStack(content: {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill().foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    // 限定字體因寬高限制而縮小的最小比率，此處為 1/100
                    .minimumScaleFactor(0.01)
                    // 設定 Text 的 寬&高比例是正方形 (1:1)
                    .aspectRatio(1, contentMode: .fit)
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
}




#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
