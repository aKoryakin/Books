//
//  ListView.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import SwiftUI

struct ListView: View {
    
    enum Style {
        case white, black
    }
    
    struct Config: Identifiable {
        var id: String {
            title
        }
        let title: String
        let itemConfigs: [ListItem.Config]
        var style: Style = .white
        
        static let empty: Self = .init(title: "", itemConfigs: [])
    }
    
    let config: Config
    
    // may be styled in the future
    private let itemsSpacing: CGFloat = 8
    private let itemsWidth: CGFloat = 120
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(config.title)
                .font(config.style.titleFont())
                .foregroundColor(config.style.titleColor())
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: itemsSpacing) {
                    ForEach(config.itemConfigs) { itemConfig in
                        ListItem(config: itemConfig)
                            .frame(width: itemsWidth)
                    }
                }
                .padding(.bottom, 8)
                .padding(.leading, 16)
            }
        }
    }
}
