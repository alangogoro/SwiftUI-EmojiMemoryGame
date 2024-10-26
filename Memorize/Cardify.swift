//
//  Cardify.swift
//  Memorize
//
//  Created by usr on 2024/10/26.
//

import SwiftUI

/// 卡片化 ViewModifier
struct Cardify: ViewModifier {
    let isFaceUp: Bool

    func body(content: Content) -> some View {
        // Functional Programming 將函式作為參數傳遞
        // 比如下VStack的 content 參數
        ZStack(content: {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                // opacity 透明度
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)

            /* 點擊 ZStack 時觸發
             .onTapGesture(perform: {
             card.isFaceUp.toggle()
             }) */
        })
    }

    struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    /// 擴充 cardify(卡片化) 方法
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
