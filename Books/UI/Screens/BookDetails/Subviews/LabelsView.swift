//
//  LabelsView.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import SwiftUI

struct LabelsView: View {
    struct Config {
        let itemConfigs: [LabelsViewItem.Config]
        
        static let empty: Self = .init(itemConfigs: [])
    }
    
    let config: Config
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(config.itemConfigs) { itemConfig in
                LabelsViewItem(config: itemConfig)
            }
        }
    }
}
