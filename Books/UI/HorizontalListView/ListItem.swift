//
//  ListItem.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import SwiftUI

struct ListItem: View {
    
    struct Config: Identifiable {
        var id: Int
        var image: String
        var text: String
        var action: (() -> Void)?
        var style: ListView.Style = .white
    }
    
    let config: Config
    
    // may be styled in the future
    private let imageCornerRadius: CGFloat = 16
    private let textAlignment: TextAlignment = .center
    private let lineLimit: Int = 3
    private let imageWidth: CGFloat = 120
    private let imageHeight: CGFloat = 150
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack(spacing: spacing) {
            Button(action: {
                config.action?()
            }) {
                AsyncImage(url: URL(string: config.image))
                    .frame(width: imageWidth, height: imageHeight)
                    .cornerRadius(imageCornerRadius)
            }
            
            Text(config.text)
                .font(config.style.itemFont())
                .foregroundColor(config.style.itemTextColor())
                .multilineTextAlignment(textAlignment)
                .lineLimit(lineLimit)
            
            Spacer()
        }
        .padding()
    }
}
