//
//  TopBannerSlide.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import Foundation

struct TopBannerSlideDTO: Decodable {
    let id: Int
    let bookId: Int
    let coverUrl: String

    private enum CodingKeys: String, CodingKey {
        case id
        case bookId = "book_id"
        case coverUrl = "cover"
    }
}
