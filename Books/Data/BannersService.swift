//
//  BannersService.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import Foundation
import Combine

class BannersService {

    private let networking: Networking
    private let cache: BannersDataProtocol
    
    // MARK: - Initializations
    init(networking: Networking, cache: BannersDataProtocol) {
        self.networking = networking
        self.cache = cache
    }
    
    // MARK: - Public methods
    func getBanners() -> AnyPublisher<[Banner], Never> {
        cache.getBannersPublisher()
    }
    
    func fetchBanners() -> AnyPublisher<Void, Error> {
        return networking.fetchData(forKey: "json_data")
            .tryMap { [weak self] data in
                let response = try JSONDecoder().decode(FullResponseDTO.self, from: data)
                let banners = response.topBannerSlides.map { bannerDTO in
                    Banner.fromDTO(bannerDTO)
                }
                self?.cache.storeBanners(banners)
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
