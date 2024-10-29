//
//  Cardify.swift
//  Memorize
//
//  Created by usr on 2024/10/26.
//

import SwiftUI

/// 卡片化 ViewModifier
//                        遵從 Animatable，以實現自定義的動畫
struct Cardify: ViewModifier, Animatable {
    var isFaceUp: Bool {
        rotation < 90
    }

    var rotation: Double
    // Animatable 協定須實作 animatableData 屬性
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

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
        // 3D旋轉動畫
        .rotation3DEffect(.degrees(rotation),
                          axis: (0, 1, 0))
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
