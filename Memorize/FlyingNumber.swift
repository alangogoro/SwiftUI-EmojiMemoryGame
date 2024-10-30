//
//  FlyingNumber.swift
//  Memorize
//
//  Created by usr on 2024/10/29.
//

import SwiftUI

struct FlyingNumber: View {
    var number: Int
    @State private var offset: CGFloat = 0
    
    var body: some View {
        if number == 0 {
            Color.clear
        } else {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(radius: 1.5, x: 1, y: 1)
                .offset(x: 0, y: offset)
            
            /* 當 offset(分數Text 飛行位移) 在 withAnimation 內變化時
             * opacity(透明度) 也會動畫式淡出 */
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        offset = number < 0 ? 200: -200
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
