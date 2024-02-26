//
//  BooksApp.swift
//  Books
//
//  Created by Alex on 21.02.2024.
//

import SwiftUI
import FirebaseCore

@main
struct BooksApp: App {

    let appContainer: AppContainer
    
    init() {
        FirebaseApp.configure()
        appContainer = .init()
    }
    
    var body: some Scene {
        WindowGroup {
            appContainer.makeRouterAssembly().view()
        }
    }
}
