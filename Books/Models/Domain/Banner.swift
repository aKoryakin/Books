//
//  Banner.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation

struct Banner {
    let id: Int
    let bookId: Int
    let coverUrl: String
    
    static func fromDTO(_ model: TopBannerSlideDTO) -> Self {
        Self(id: model.id, bookId: model.bookId, coverUrl: model.coverUrl)
    }
}
