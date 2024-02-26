//
//  SliderItem.swift
//  Books
//
//  Created by Alex on 23.02.2024.
//

import SwiftUI

struct SliderItem: View {
    
    struct Config: Identifiable {
        var id: Int
        let image: String
        let title: String?
        let subtitle: String?
        var imageCornerRadius: CGFloat = 16
        var textColor: Color = .white
        var titleFont: Font = .customFont(font: .nunitoSans, style: .bold, size: .s20)
        var subtitleFont: Font = .customFont(font: .nunitoSans, style: .regular, size: .s14)
        var imageWidth: CGFloat = UIScreen.main.bounds.width - 32
        var imageHeight: CGFloat = 160
        var spacing: CGFloat = 4
        var action: (() -> Void)?
        
        static let empty: Self = .init(id: 0, image: "", title: "", subtitle: "")
    }
    
    let config: Config
    
    var body: some View {
        Button(action: {
            config.action?()
        }) {
            AsyncImage(url: URL(string: config.image))
                .frame(width: config.imageWidth, height: config.imageHeight)
                .cornerRadius(config.imageCornerRadius)
                .aspectRatio(contentMode: .fit)
            //                .padding(.horizontal, 16)
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}
