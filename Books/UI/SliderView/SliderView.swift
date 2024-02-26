//
//  SliderView.swift
//  Books
//
//  Created by Alex on 23.02.2024.
//

import SwiftUI

struct SliderView: View {

    struct Config {
        let itemConfigs: [SliderItem.Config]
        static let empty: Self = .init(itemConfigs: [])
    }

    let config: Config
    @State private var currentIndex = 0

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(config.itemConfigs, id: \.id) { itemConfig in
                        SliderItem(config: itemConfig)
                    }
                }
            }
            .clipped()
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
        }
    }
}
