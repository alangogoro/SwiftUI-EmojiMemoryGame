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
    var isFaceUp: Bool = false

    var body: some View {
        
        // Functional Programming 將函式作為參數傳遞
        // 比如下VStack的 content 參數
        ZStack(content: {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        })
        .padding()               // Modifier
        .foregroundColor(.orange)// Modifier

    }
}




#Preview {
    ContentView()
}
