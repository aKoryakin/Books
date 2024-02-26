//
//  BannersDataProtocol.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation
import Combine

protocol BannersDataProtocol {
    func getBannersPublisher() -> AnyPublisher<[Banner], Never>
    func storeBanners(_ banners: [Banner])
}
