//
//  RouterView.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import SwiftUI

struct RouterView: View {
    
    @StateObject var router: Router
    @ObservedObject var errorHandler: PrimitiveErrorHandler
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                if router.needChangeRootView {
                    router.rootView()
                } else {
                    router.rootView()
                }
            }
            .navigationDestination(for: Router.Route.self) { route in
                router.view(for: route)
            }
        }
        .errorAlert(error: $errorHandler.error)
    }
}
