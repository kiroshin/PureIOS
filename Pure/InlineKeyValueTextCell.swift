//
//  InlineKeyValueTextCell.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import SwiftUI

struct InlineKeyValueTextCell: View {
    let key: String
    let value: String
    let fixedKeyWidth: CGFloat
    
    var body: some View {
        HStack {
            Text(key)
                .frame(minWidth: fixedKeyWidth, alignment: .leading)
            Text(value)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct InlineKeyValueTextCell_Previews: PreviewProvider {
    static var previews: some View {
        InlineKeyValueTextCell(key: "KEY", value: "VALUE", fixedKeyWidth: 4 * 20)
    }
}
