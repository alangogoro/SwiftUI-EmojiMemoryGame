//
//  ContentView.swift
//  Memorize
//
//  Created by usr on 2024/8/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
        }
        .padding()
    }

}

// MARK: 卡片視圖
struct CardView: View {
    @State var isFaceUp = false

    var body: some View {
        
        // Functional Programming 將函式作為參數傳遞
        // 比如下VStack的 content 參數
        ZStack(content: {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                base.fill()
            }
        })
        .foregroundColor(.orange)// Modifier
        // 點擊 ZStack 時觸發
        .onTapGesture(perform: {
            isFaceUp.toggle()
        })

    }
}




#Preview {
    ContentView()
}
