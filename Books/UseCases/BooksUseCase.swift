//
//  BooksUseCase.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation
import Combine

class BooksUseCase {

    private let bookService: BooksService
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializations
    init(bookService: BooksService) {
        self.bookService = bookService
    }
    
    // MARK: - Public methods
    func syncBooks() -> AnyPublisher<Void, Error> {
        bookService.fetchBooks()
    }
    
    func syncRecommendedBooks() -> AnyPublisher<Void, Error> {
        bookService.fetchRecommendedBooks()
    }
    
    func syncWillLikeBookIds() -> AnyPublisher<Void, Error> {
        bookService.fetchYouWillLikeBooks()
    }
    
    func getBook(by id: Int) -> AnyPublisher<Book?, Never> {
        bookService.getBook(by: id)
    }
    
    func getBooks() -> AnyPublisher<[Book], Never> {
        bookService.getBooks()
    }
    
    func getRecommendedBooks() -> AnyPublisher<[Book], Never> {
        bookService.getRecommendedBooks()
    }
    
    func getWillLikeBookIds() -> AnyPublisher<[Int], Never> {
        bookService.getWillLikeBookIds()
    }
}
