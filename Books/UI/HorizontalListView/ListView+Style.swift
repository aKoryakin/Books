//
//  ListView+Style.swift
//  Books
//
//  Created by Alex on 26.02.2024.
//

import Foundation
import SwiftUI

extension ListView.Style {
    func titleFont() -> Font {
        switch self {
        case .white:
            return titleFontWhiteStyle()
        case . black:
            return titleFontBlackStyle()
        }
    }
    
    func titleColor() -> Color {
        switch self {
        case .white:
            return titleColorWhiteStyle()
        case . black:
            return titleColorBlackStyle()
        }
    }
    
    func itemTextColor() -> Color {
        switch self {
        case .white:
            return itemTextColorWhiteStyle()
        case . black:
            return itemTextColorBlackStyle()
        }
    }
    
    func itemFont() -> Font {
        switch self {
        case .white:
            return itemFontWhiteStyle()
        case . black:
            return itemFontBlackStyle()
        }
    }
}

// MARK: - White
extension ListView.Style {
    private func titleFontWhiteStyle() -> Font {
        .customFont(font: .nunitoSans, style: .bold, size: .s20)
    }
    
    private func titleColorWhiteStyle() -> Color {
        .white
    }
    
    private func itemTextColorWhiteStyle() -> Color {
        .white.opacity(0.7)
    }
    
    private func itemFontWhiteStyle() -> Font {
        .customFont(font: .nunitoSans, style: .regular, size: .s16)
    }
}

// MARK: - Black
extension ListView.Style {
    private func titleFontBlackStyle() -> Font {
        .customFont(font: .nunitoSans, style: .bold, size: .s20)
    }
    
    private func titleColorBlackStyle() -> Color {
        .darkGrayText
    }
    
    private func itemTextColorBlackStyle() -> Color {
        .grayText
    }
    
    private func itemFontBlackStyle() -> Font {
        .customFont(font: .nunitoSans, style: .regular, size: .s16)
    }
}
