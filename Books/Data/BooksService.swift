//
//  BooksService.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import Foundation
import Combine

class BooksService {
    
    private let networking: Networking
    private let cache: BooksDataProtocol
    
    // MARK: - Initializations
    init(networking: Networking, cache: BooksDataProtocol) {
        self.networking = networking
        self.cache = cache
    }
    
    // MARK: - Public methods
    func getBooks() -> AnyPublisher<[Book], Never> {
        cache.getBooksPublisher()
    }
    
    func getRecommendedBooks() -> AnyPublisher<[Book], Never> {
        cache.getRecommendedBooksPublisher()
    }
    
    func getWillLikeBookIds() -> AnyPublisher<[Int], Never> {
        cache.getWillLikeBookIdsPublisher()
    }
    
    func getBook(by id: Int) -> AnyPublisher<Book?, Never> {
        return getBooks()
            .map { books in
                books.first { book in
                    book.id == id
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchBooks() -> AnyPublisher<Void, Error> {
        return networking.fetchData(forKey: "json_data")
            .tryMap { [weak self] data in
                let response = try JSONDecoder().decode(FullResponseDTO.self, from: data)
                let books = response.books.map { bookDTO in
                    Book.fromDTO(bookDTO)
                }
                self?.cache.storeBooks(books)
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    func fetchYouWillLikeBooks() -> AnyPublisher<Void, Error> {
        return networking.fetchData(forKey: "json_data")
            .tryMap { [weak self] data in
                let response = try JSONDecoder().decode(FullResponseDTO.self, from: data)
                self?.cache.storeWillLikeBookIds(response.youWillLikeSection)
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    func fetchRecommendedBooks() -> AnyPublisher<Void, Error> {
        return networking.fetchData(forKey: "details_carousel")
            .tryMap { [weak self] data in
                let response = try JSONDecoder().decode(BooksResponseDTO.self, from: data)
                let books = response.books.map { bookDTO in
                    Book.fromDTO(bookDTO)
                }
                self?.cache.storeRecommendedBooks(books)
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
