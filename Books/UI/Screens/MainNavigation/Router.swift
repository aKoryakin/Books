//
//  Router.swift
//  Books
//
//  Created by Alex on 23.02.2024.
//

import Foundation
import SwiftUI

protocol Navigation {
    func navigateTo(_ route: Router.Route)
    func setRootViewRoute(_ route: Router.Route)
    func navigateBack()
    func popToRoot()
}

final class Router: ObservableObject {
    
    enum Route: Hashable {
        case launch, library, bookDetails(id: Int)
    }
    
    let container: AppContainer
    
    @Published var path = NavigationPath()
    @Published var needChangeRootView: Bool = false
    
    private var rootViewRoute: Route = .launch
    private lazy var launchAssembly: LaunchAssembly = {
        container.makeLaunchAssembly(router: self)
    }()
    private lazy var libraryAssembly: LibraryAssembly = {
        container.makeLibraryAssembly(router: self)
    }()
    private var bookDetailsAssembly: BookDetailsAssembly? = nil
        
    init(container: AppContainer) {
        self.container = container
    }
    
    @ViewBuilder func rootView() -> some View {
        view(for: rootViewRoute)
    }
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .launch:
            launchAssembly.view()
        case .library:
            libraryAssembly.view()
        case .bookDetails:
            if let bookDetailsView = bookDetailsAssembly?.view() {
                bookDetailsView
            } else {
                EmptyView()
            }
        }
    }
    
    // MARK: Assembly helpers
    private func makeBookDetailsAssembly(_ id: Int) {
        bookDetailsAssembly = container.makeBookDetailsAssembly(id, router: self)
    }
    
    private func makeAssemblyIfNeeded(for route: Route) {
        switch route {
        case .bookDetails(let id):
            makeBookDetailsAssembly(id)
        default:
            break
        }
    }
}

extension Router: Navigation {
    // MARK: - Navigation
    func setRootViewRoute(_ route: Route) {
        rootViewRoute = route
        needChangeRootView = true
    }
    
    func navigateTo(_ route: Route) {
        makeAssemblyIfNeeded(for: route)
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
