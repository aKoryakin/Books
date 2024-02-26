//
//  BooksDataProtocol.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation
import Combine

protocol BooksDataProtocol {
    func getBooksPublisher() -> AnyPublisher<[Book], Never>
    func getRecommendedBooksPublisher() -> AnyPublisher<[Book], Never>
    func getWillLikeBookIdsPublisher() -> AnyPublisher<[Int], Never>
    func storeBooks(_ books: [Book])
    func storeWillLikeBookIds(_ ids: [Int])
    func storeRecommendedBooks(_ books: [Book])
}
