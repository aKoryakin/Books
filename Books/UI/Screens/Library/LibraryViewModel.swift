//
//  LibraryViewModel.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import Foundation
import Combine

final class LibraryViewModel: ObservableObject, LibraryViewVMP {
    @Published var listViewConfigs: [ListView.Config] = []
    @Published var sliderViewConfig: SliderView.Config = .empty
    
    private let booksUseCase: BooksUseCase
    private let bannersUseCase: BannersUseCase
    private let router: LibraryRouter
    private let errorHandler: PrimitiveErrorHandler
    private var cancellables = Set<AnyCancellable>()
    private var syncBooksCancellable: AnyCancellable?
    private var syncBannersCancellable: AnyCancellable?
    
    init(
        booksUseCase: BooksUseCase,
        bannersUseCase: BannersUseCase,
        router: LibraryRouter,
        errorHandler: PrimitiveErrorHandler
    ) {
        self.booksUseCase = booksUseCase
        self.bannersUseCase = bannersUseCase
        self.router = router
        self.errorHandler = errorHandler
        
        syncData()
        generateState()
    }
    
    private func syncData() {
        syncBooksCancellable = booksUseCase.syncBooks()
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
        
        syncBannersCancellable = bannersUseCase.syncBanners()
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
        booksUseCase.getBooks()
            .map(configureListViewConfigs)
            .receive(on: DispatchQueue.main)
            .assign(to: \.listViewConfigs, on: self)
            .store(in: &cancellables)
        
        bannersUseCase.getBanners()
            .map(configureSliderViewConfig)
            .receive(on: DispatchQueue.main)
            .assign(to: \.sliderViewConfig, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: Books helpers
    private func configureListViewConfigs(books: [Book]) -> [ListView.Config] {
        return Dictionary(grouping: books, by: { $0.genre })
            .compactMap { [weak self] (genre: String, books: [Book]) in
                guard let self = self else { return .empty }
                return ListView.Config(
                    title: genre,
                    itemConfigs: self.toListItemConfigs(books: books)
                )
            }
            .sorted { $0.title < $1.title }
    }
    
    private func toListItemConfigs(books: [Book]) -> [ListItem.Config] {
        return books.map { [unowned self] book in
            return self.toListItemConfig(book: book)
        }
    }
    
    private func toListItemConfig(book: Book) -> ListItem.Config {
        return ListItem.Config(id: book.id,
                               image: book.coverUrl,
                               text: book.name) { [weak self] in
            
            self?.showBookDetailsScreen(book.id)
        }
    }
    
    // MARK: Banners helpers
    private func configureSliderViewConfig(banners: [Banner]) -> SliderView.Config {
        let sliderItemConfigs: [SliderItem.Config] = toSliderItemConfigs(banners: banners)
        
        return SliderView.Config(itemConfigs: sliderItemConfigs)
    }
    
    private func toSliderItemConfigs(banners: [Banner]) -> [SliderItem.Config] {
        return banners.map { [weak self] banner in
            guard let self = self else { return .empty }
            return self.toSliderItemConfig(banner: banner)
        }
    }

    private func toSliderItemConfig(banner: Banner) -> SliderItem.Config {
        return SliderItem.Config(id: banner.id,
                                 image: banner.coverUrl,
                                 title: nil,
                                 subtitle: nil) { [weak self] in

            self?.showBookDetailsScreen(banner.bookId)
        }
    }
    
    // MARK: - Route
    private func showBookDetailsScreen(_ id: Int) {
        router.goToBookDetails(id)
    }
}
