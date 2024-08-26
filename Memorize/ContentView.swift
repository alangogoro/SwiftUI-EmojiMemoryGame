//
//  ContentView.swift
//  Memorize
//
//  Created by usr on 2024/8/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "😈", "💀", "🧙🏻‍♀️", "🕸️", "👺"]
    @State var cardCount: Int = 3

    var body: some View {
        VStack {
            ScrollView {
                // LazyGride 會盡可能內縮
                // GridItem 可以設置欄位大小
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                    // ForEach View
                    ForEach(0..<cardCount, id: \.self) { index in
                        CardView(content: emojis[index])
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.orange)// Modifier
            }

            Spacer()

            HStack {
                cardAdder
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
        // 在 … 情況下設為禁用
        .disabled(cardCount > emojis.count - 1)
    }
    
    /// 減卡片按鈕
    var cardRemover: some View {
        Button {
            cardCount -= 1
        } label: {
            Image(systemName: "rectangle.stack.badge.minus.fill")
        }
        // 在 … 情況下設為禁用
        .disabled(cardCount <= 1)
    }
}

// MARK: 卡片視圖
struct CardView: View {
    let content: String
    @State var isFaceUp = false

    var body: some View {

        // Functional Programming 將函式作為參數傳遞
        // 比如下VStack的 content 參數
        ZStack(content: {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill().foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            // opacity 透明度
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        })
        // 點擊 ZStack 時觸發
        .onTapGesture(perform: {
            isFaceUp.toggle()
        })

    }
}




#Preview {
    ContentView()
}
