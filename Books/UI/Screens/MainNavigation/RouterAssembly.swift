//
//  RouterAssembly.swift
//  Books
//
//  Created by Alex on 24.02.2024.
//

final class RouterAssembly {
    private let container: AppContainer
    private let errorHandler: PrimitiveErrorHandler

    init(container: AppContainer, errorHandler: PrimitiveErrorHandler) {
        self.container = container
        self.errorHandler = errorHandler
    }
    
    func view() -> RouterView {
        let router = Router(container: container)
        return RouterView(router: router, errorHandler: errorHandler)
    }
}
