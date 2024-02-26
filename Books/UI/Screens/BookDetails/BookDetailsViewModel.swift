//
//  BookDetailsViewModel.swift
//  Books
//
//  Created by Alex on 23.02.2024.
//

import Foundation
import Combine

final class BookDetailsViewModel: ObservableObject, BookDetailsViewVMP {
    
    @Published var carouselViewConfig: CarouselView.Config = .empty
    @Published var listViewConfig: ListView.Config = .empty
    @Published var labelsViewConfig: LabelsView.Config = .empty
    @Published var textsViewConfig: TextsView.Config = .empty
    
    @Published private var selectedBookId: Int
    @Published private var books: [Book] = []
    private let booksUseCase: BooksUseCase
    private let router: BookDetailsRouter
    private let errorHandler: PrimitiveErrorHandler
    private var cancellables = Set<AnyCancellable>()
    private var syncRecommendedBooksCancellable: AnyCancellable?
    private var syncWillLikeBookIdsCancellable: AnyCancellable?
    
    init(
        selectedBookId: Int,
        booksUseCase: BooksUseCase,
        router: BookDetailsRouter,
        errorHandler: PrimitiveErrorHandler
    ) {
        self.selectedBookId = selectedBookId
        self.booksUseCase = booksUseCase
        self.router = router
        self.errorHandler = errorHandler
        
        syncData()
        generateState()
    }
    
    func backButtonAction() {
        router.goBack()
    }
    
    // MARK: - Helpers
    private func syncData() {
        syncRecommendedBooksCancellable = booksUseCase.syncRecommendedBooks()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self?.errorHandler.showError(error)
                }
            }, receiveValue: { _ in })
        
        syncWillLikeBookIdsCancellable = booksUseCase.syncWillLikeBookIds()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                    self?.errorHandler.showError(error)
                }
            }, receiveValue: { _ in })
    }
    
    private func generateState() {
        booksUseCase.getRecommendedBooks()
            .map(configureCarouselViewConfig)
            .receive(on: DispatchQueue.main)
            .assign(to: \.carouselViewConfig, on: self)
            .store(in: &cancellables)
        
        booksUseCase.getBooks()
            .receive(on: DispatchQueue.main)
            .assign(to: \.books, on: self)
            .store(in: &cancellables)
        
        booksUseCase.getWillLikeBookIds()
            .map(configureListViewConfig)
            .receive(on: DispatchQueue.main)
            .assign(to: \.listViewConfig, on: self)
            .store(in: &cancellables)
        
        booksUseCase.getRecommendedBooks().combineLatest($selectedBookId)
            .compactMap(configureTextsViewConfig)
            .receive(on: DispatchQueue.main)
            .assign(to: \.textsViewConfig, on: self)
            .store(in: &cancellables)
        
        booksUseCase.getRecommendedBooks().combineLatest($selectedBookId)
            .compactMap(configureLabelsViewConfig)
            .receive(on: DispatchQueue.main)
            .assign(to: \.labelsViewConfig, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Carousel view config
    private func configureCarouselViewConfig(books: [Book]) -> CarouselView.Config {
        let items = books
            .compactMap { [weak self] book in
                self?.toCarouselItem(book: book)
            }
        
        return CarouselView.Config(items: items) { [weak self] item in
            self?.selectedBookId = item.id
        }
    }
    
    private func toCarouselItem(book: Book) -> CarouselView.Item {
        CarouselView.Item(
            id: book.id,
            image: book.coverUrl,
            title: book.name,
            subtitle: book.author
        )
    }
    
    // MARK: - List view config
    private func configureListViewConfig(bookIds: [Int]) -> ListView.Config {
        let books = booksByIds(ids: bookIds)
        let itemConfigs = toListItemConfigs(books: books)
        
        return ListView.Config(title: "You will also like", itemConfigs: itemConfigs, style: .black)
    }
    
    private func toListItemConfigs(books: [Book]) -> [ListItem.Config] {
        return books.map { [unowned self] book in
            return self.toListItemConfig(book: book)
        }
    }
    
    private func toListItemConfig(book: Book) -> ListItem.Config {
        return ListItem.Config(id: book.id,
                               image: book.coverUrl,
                               text: book.name,
                               style: .black)
    }
    
    private func booksByIds(ids: [Int]) -> [Book] {
        ids
            .compactMap { id in
                books.first(where: { book in
                    book.id == id
                })
            }
    }
    
    // MARK: - Texts view config
    private func configureTextsViewConfig(_ recommendedBooks: [Book], selectedBookId: Int) -> TextsView.Config? {
        if let book = recommendedBooks.first(where: { $0.id == selectedBookId }) {
            return TextsView.Config(title: "Summary", content: book.summary)
        } else {
            return nil
        }
    }
    
    // MARK: - Labels view config
    private func configureLabelsViewConfig(_ recommendedBooks: [Book], selectedBookId: Int) -> LabelsView.Config? {
        if let book = recommendedBooks.first(where: { $0.id == selectedBookId }) {
            return LabelsView.Config(itemConfigs: createLabelsViewItemConfigs(book: book))
        } else {
            return nil
        }
    }
    
    private func createLabelsViewItemConfigs(book: Book) -> [LabelsViewItem.Config] {
        return [
            LabelsViewItem.Config(title: book.views, label: "Readers"),
            LabelsViewItem.Config(title: book.likes, label: "Likes"),
            LabelsViewItem.Config(title: book.quotes, label: "Quotes"),
            LabelsViewItem.Config(title: book.genre, label: "Genre", imageName: "flame")
        ]
    }
}
