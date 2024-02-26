//
//  LibraryAssembly.swift
//  Books
//
//  Created by Alex on 23.02.2024.
//

import SwiftUI

protocol LibraryContainer {
    func makeBooksUseCase() -> BooksUseCase
    func makeBannersUseCase() -> BannersUseCase
    func makeErrorHandler() -> PrimitiveErrorHandler
}

final class LibraryAssembly {
    private let container: LibraryContainer
    private let router: Navigation

    init(container: LibraryContainer, router: Navigation) {
        self.container = container
        self.router = router
    }

    func view() -> LibraryView {
        let booksUseCase = container.makeBooksUseCase()
        let bannersUseCase = container.makeBannersUseCase()
        let libraryRouter = LibraryRouter(router: router)
        let errorHandler = container.makeErrorHandler()
        
        let viewModel = LibraryViewModel(
            booksUseCase: booksUseCase,
            bannersUseCase: bannersUseCase,
            router: libraryRouter,
            errorHandler: errorHandler
        )
        return LibraryView(viewModel: viewModel)
    }
}
