//
//  TextsView.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import SwiftUI

struct TextsView: View {
    
    struct Config {
        let title: String
        let content: String
        
        static let empty: Self = .init(title: "", content: "")
    }
    
    let config: Config
    
    var body: some View {
        VStack(spacing: 16) {
            Color.lightGrayText.frame(height: 1)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(config.title)
                        .font(.customFont(font: .nunitoSans, style: .bold, size: .s20))
                        .foregroundColor(.darkGrayText)
                }
                
                Text(config.content)
                    .font(.customFont(font: .nunitoSans, style: .regular, size: .s14))
                    .foregroundColor(.grayText)
            }
            
            Color.lightGrayText.frame(height: 1)
        }
        .padding(.horizontal, 16)
    }
}
