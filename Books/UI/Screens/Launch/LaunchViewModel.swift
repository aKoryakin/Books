//
//  LaunchViewModel.swift
//  Books
//
//  Created by Alex on 22.02.2024.
//

import Combine
import Foundation

final class LaunchViewModel: ObservableObject, LaunchViewVMP {
    @Published var progress: Double = 0.0
    
    private let router: LaunchRouter
    private var cancellables = Set<AnyCancellable>()
    
    init(router: LaunchRouter) {
        self.router = router
    }
    
    func startProgress() {
        let interval = 0.02
        let totalTime = 2.0
        let steps = Int(totalTime / interval)
        let increment = 1.0 / Double(steps)
        
        Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .prefix(steps)
            .scan(0.0) { progress, _ in
                let newProgress = progress + increment
                return newProgress > 1 ? 1 : newProgress
            }
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.showLibraryScreen()
            })
            .assign(to: \.progress, on: self)
            .store(in: &cancellables)
    }
    
    private func showLibraryScreen() {
        router.goToLibrary()
    }
}
