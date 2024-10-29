//
//  AspectVGrid.swift
//  Memorize
//
//  Created by usr on 2024/10/24.
//

import SwiftUI

struct AspectVGrid<Item, ItemView: View>: View where Item: Identifiable {
    var items: [Item]
    /// 將 Item 轉變成自定義的 ItemView 並返回
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    var body: some View {

        GeometryReader { geometry in
            let gridItemSize = gridItemThatFits(count: items.count,
                                                size: geometry.size,
                                                atAspectRatio: aspectRatio)

            /* LazyGride 會盡可能內縮
             * GridItem 可以設置欄位大小 */
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)],
                      spacing: 0) {
                /* ForEach View
                 * 參數id：給 ForEach 分辨物件的識別碼（有唯一性） */
                ForEach(items) { item in
                    content(item)
                        // 設定 GridItem 的 寬&高比例
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }

    }
    
    /// 根據卡片張數、寬高比，與 view 的尺寸來計算 GridItem 的大小
    func gridItemThatFits(count: Int, size: CGSize, atAspectRatio aspcetRatio: CGFloat)
    -> CGFloat {
        let count = CGFloat(count)
        var columnCount = CGFloat(1)
        
        repeat {
            let width = size.width / columnCount
            let height = width * aspcetRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            
            columnCount += 1
        } while columnCount < count
        
        return min(size.width / count, size.height * aspcetRatio).rounded(.down)
    }
}
