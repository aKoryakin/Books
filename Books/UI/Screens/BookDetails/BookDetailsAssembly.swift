//
//  BookDetailsAssembly.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

protocol BookDetailsContainer {
    func makeBooksUseCase() -> BooksUseCase
    func makeErrorHandler() -> PrimitiveErrorHandler
}

final class BookDetailsAssembly {
    private let container: BookDetailsContainer
    private let router: Navigation
    private let selectedBookId: Int
    
    init(selectedBookId: Int, container: BookDetailsContainer, router: Navigation) {
        self.container = container
        self.router = router
        self.selectedBookId = selectedBookId
    }
    
    func view() -> BookDetailsView {
        let booksUseCase = container.makeBooksUseCase()
        let bookDetailsRouter = BookDetailsRouter(router: router)
        let errorHandler = container.makeErrorHandler()
        
        let viewModel = BookDetailsViewModel(
            selectedBookId: selectedBookId,
            booksUseCase: booksUseCase,
            router: bookDetailsRouter,
            errorHandler: errorHandler
        )
        return BookDetailsView(viewModel: viewModel)
    }
}
