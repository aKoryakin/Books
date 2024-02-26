//
//  SnapCarousel.swift
//  Books
//
//  Created by Alex on 26.02.2024.
//

import SwiftUI

struct CarouselView: View {
    
    struct Item: Identifiable {
        let id: Int
        let image: String
        let title: String
        let subtitle: String
    }
    
    struct Config {
        let items: [CarouselView.Item]
        var selectedItem: ((Item) -> Void)?
        
        static let empty: Self = .init(items: [], selectedItem: nil)
    }
    
    let config: Config
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    
    init(config: Config) {
        self.config = config
        
        let heightCoefficient: CGFloat = 1.25
        let widthCoefficient: CGFloat = 1.875
        width = UIScreen.main.bounds.width / widthCoefficient
        height = width * heightCoefficient
    }
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<config.items.count, id: \.self) { index in
                    VStack {
                        AsyncImage(url: URL(string: config.items[index].image))
                            .frame(width: width, height: height)
                            .cornerRadius(16)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.0 : 0.75)
                            .offset(x: CGFloat(index - currentIndex) * width + dragOffset, y: 0)
                        
                        if currentIndex == index {
                            VStack(spacing: 4) {
                                Text(config.items[index].title)
                                    .font(.customFont(font: .nunitoSans, style: .bold, size: .s20))
                                    .foregroundColor(.white)
                                Text(config.items[index].subtitle)
                                    .font(.customFont(font: .nunitoSans, style: .bold, size: .s14))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(config.items.count - 1, currentIndex + 1)
                            }
                        }
                    }
            )
            .onChange(of: currentIndex) { index in
                config.selectedItem?(config.items[index])
            }
        }
    }
}
