//
//  Book.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import Foundation

struct FullResponseDTO: Decodable {
    let books: [BookDTO]
    let topBannerSlides: [TopBannerSlideDTO]
    let youWillLikeSection: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case books
        case topBannerSlides = "top_banner_slides"
        case youWillLikeSection = "you_will_like_section"
    }
}

struct BooksResponseDTO: Decodable {
    let books: [BookDTO]
}

struct BookDTO: Decodable {
    let id: Int
    let name: String
    let author: String
    let summary: String
    let genre: String
    let coverUrl: String
    let views: String
    let likes: String
    let quotes: String

    private enum CodingKeys: String, CodingKey {
        case id, name, author, summary, genre, views, likes, quotes
        case coverUrl = "cover_url"
    }
}
