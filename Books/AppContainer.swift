//
//  AppContainer.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation
import SwiftUI

final class AppContainer {
    private let firebaseService: FirebaseService
    private let booksService: BooksService
    private let bannersService: BannersService
    private let booksUseCase: BooksUseCase
    private let bannersUseCase: BannersUseCase
    private let errorHandler: PrimitiveErrorHandler
    private let cache: Cache
    
    init() {
        firebaseService = .init()
        cache = .init()
        errorHandler = .init()
        
        booksService = BooksService(networking: firebaseService, cache: cache)
        bannersService = BannersService(networking: firebaseService, cache: cache)
        
        booksUseCase = BooksUseCase(bookService: booksService)
        bannersUseCase = BannersUseCase(bannersService: bannersService)
    }
}

extension AppContainer {
    func makeRouterAssembly() -> RouterAssembly {
        return RouterAssembly(container: self, errorHandler: errorHandler)
    }
}

// MARK: - Launch screen
extension AppContainer {
    func makeLaunchAssembly(router: Router) -> LaunchAssembly {
        return LaunchAssembly(router: router)
    }
}

// MARK: - Library screen
extension AppContainer: LibraryContainer {
    func makeBooksUseCase() -> BooksUseCase {
        booksUseCase
    }
    
    func makeBannersUseCase() -> BannersUseCase {
        bannersUseCase
    }
    
    func makeLibraryAssembly(router: Router) -> LibraryAssembly {
        return LibraryAssembly(container: self, router: router)
    }
    
    func makeErrorHandler() -> PrimitiveErrorHandler {
        errorHandler
    }
}

// MARK: - Book details screen
extension AppContainer: BookDetailsContainer {
    func makeBookDetailsAssembly(_ id: Int, router: Router) -> BookDetailsAssembly {
        return BookDetailsAssembly(selectedBookId: id, container: self, router: router)
    }
}
