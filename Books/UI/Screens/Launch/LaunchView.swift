//
//  LaunchView.swift
//  Books
//
//  Created by Alex on 21.02.2024.
//

import SwiftUI

protocol LaunchViewVMP {
    var progress: Double { get }
    func startProgress()
}

struct LaunchView: View {
    @ObservedObject var viewModel: LaunchViewModel
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            Image("background_hearts")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack {
                textsView
                    .padding(.vertical, 20)
                
                progressView
                    .padding(.horizontal, 50)
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 3)
            }
            .onAppear {
                viewModel.startProgress()
            }
        }
    }
    
    private var textsView: some View {
        VStack(spacing: 12) {
            Text("Book App")
                .font(.customFont(font: .georgia, style: .boldItalic, size: .s52))
                .foregroundColor(.customLightPink)
            
            Text("Welcome to Book App")
                .font(.customFont(font: .nunitoSans, style: .bold, size: .s24))
                .foregroundColor(.white.opacity(0.8))
            
        }
    }
    
    private var progressView: some View {
        ProgressView(value: viewModel.progress)
            .padding(.horizontal, 50)
            .frame(height: 6)
            .tint(.white)
    }
}
