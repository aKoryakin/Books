//
//  LaunchAssembly.swift
//  Books
//
//  Created by Alex on 23.02.2024.
//

final class LaunchAssembly {
    private let router: Navigation

    init(router: Navigation) {
        self.router = router
    }
    
    func view() -> LaunchView {
        let launchRouter = LaunchRouter(router: router)
        let viewModel = LaunchViewModel(router: launchRouter)
        return LaunchView(viewModel: viewModel)
    }
}
