//
//  BannersUseCase.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation
import Combine

class BannersUseCase {

    private let bannersService: BannersService
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializations
    init(bannersService: BannersService) {
        self.bannersService = bannersService
    }
    
    // MARK: - Public methods
    func syncBanners() -> AnyPublisher<Void, Error> {
        bannersService.fetchBanners()
    }
    
    func getBanners() -> AnyPublisher<[Banner], Never> {
        bannersService.getBanners()
    }
}
