//
//  BookDetailsRouter.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation

final class BookDetailsRouter {
    private let router: Navigation
    
    init(router: Navigation) {
        self.router = router
    }
    
    func goBack() {
        router.navigateBack()
    }
}
