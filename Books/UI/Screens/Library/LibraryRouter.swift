//
//  LibraryRouter.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

import Foundation

final class LibraryRouter {
    private let router: Navigation
    
    init(router: Navigation) {
        self.router = router
    }
    
    func goToBookDetails(_ bookId: Int) {
        router.navigateTo(.bookDetails(id: bookId))
    }
}
