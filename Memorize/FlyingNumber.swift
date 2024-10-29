//
//  FlyingNumber.swift
//  Memorize
//
//  Created by usr on 2024/10/29.
//

import SwiftUI

struct FlyingNumber: View {
    var number: Int
    
    var body: some View {
        Text(number, format: .number)
    }
}

#Preview {
    FlyingNumber(number: 5)
}
