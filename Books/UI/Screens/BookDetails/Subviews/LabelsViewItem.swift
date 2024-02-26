//
//  LabelsViewItem.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import SwiftUI

struct LabelsViewItem: View {
    struct Config: Identifiable {
        var id: String {
            label
        }
        let title: String
        let label: String
        var imageName: String?
    }
    
    let config: Config
    
    var body: some View {
        VStack {
            if let imageName = config.imageName {
                Label {
                    Text(config.title)
                        .font(.customFont(font: .nunitoSans, style: .bold, size: .s18))
                        .foregroundColor(.darkGrayText)
                } icon: {
                    Image(systemName: imageName)
                }
                .labelStyle(RightIconLabelStyle())
            } else {
                Label {
                    Text(config.title)
                        .font(.customFont(font: .nunitoSans, style: .bold, size: .s18))
                        .foregroundColor(.darkGrayText)
                } icon: {
                    EmptyView()
                }
                .labelStyle(TitleOnlyLabelStyle())
            }
            
            Text(config.label)
                .font(.customFont(font: .nunitoSans, style: .regular, size: .s12))
                .foregroundColor(.lightGrayText)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}


struct RightIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack() {
            configuration.title
            configuration.icon
        }
    }
}
