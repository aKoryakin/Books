//
//  Cache.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation
import Combine

class Cache: BooksDataProtocol, BannersDataProtocol {
    @Published private var books: [Book] = []
    @Published private var recommendedBooks: [Book] = []
    @Published private var willLikeBookIds: [Int] = []
    @Published private var banners: [Banner] = []
    
    // MARK: - BooksDataProtocol
    func getBooksPublisher() -> AnyPublisher<[Book], Never> {
        $books
            .eraseToAnyPublisher()
    }
    
    func storeBooks(_ books: [Book]) {
        self.books = books
    }
    
    func getRecommendedBooksPublisher() -> AnyPublisher<[Book], Never> {
        $recommendedBooks
            .eraseToAnyPublisher()
    }
    
    func storeRecommendedBooks(_ books: [Book]) {
        self.recommendedBooks = books
    }
    
    func getWillLikeBookIdsPublisher() -> AnyPublisher<[Int], Never> {
        $willLikeBookIds
            .eraseToAnyPublisher()
    }
    
    func storeWillLikeBookIds(_ ids: [Int]) {
        self.willLikeBookIds = ids
    }
    
    // MARK: - BannersDataProtocol
    func getBannersPublisher() -> AnyPublisher<[Banner], Never> {
        $banners
            .eraseToAnyPublisher()
    }
    
    func storeBanners(_ banners: [Banner]) {
        self.banners = banners
    }
}
