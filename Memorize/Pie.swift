//
//  Pie.swift
//  Memorize
//
//  Created by usr on 2024/10/26.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        #warning("iOS的座標位置，y軸是向下增長；順逆時鐘方向是從裝置本身觀察")
        // 將角度轉換為iOS座標系統
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        /// Path起點
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )

        var p = Path()
        p.move(to: center)
        // addLine （從原位中心）繪製一條線至指定處
        p.addLine(to: start)

        // addArc
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle, endAngle: endAngle,
            clockwise: false)

        // 從Arc弧線終點返回原位中心
        p.addLine(to: center)

        return p
    }

}
