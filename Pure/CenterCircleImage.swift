//
//  CenterCircleImage.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
        

import SwiftUI

struct CenterCircleImage: View {
    let url: String
    
    var body: some View {
        return HStack {
            Spacer()
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }.frame(width: 200, height: 200)
            Spacer()
        }
    }
}

