//
//  Book.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation

struct Book {
    let id: Int
    let name: String
    let author: String
    let summary: String
    let genre: String
    let coverUrl: String
    let views: String
    let likes: String
    let quotes: String
    
    static func fromDTO(_ model: BookDTO) -> Self {
        Self(
            id: model.id,
            name: model.name,
            author: model.author,
            summary: model.summary,
            genre: model.genre,
            coverUrl: model.coverUrl,
            views: model.views,
            likes: model.likes,
            quotes: model.quotes
        )
    }
}
