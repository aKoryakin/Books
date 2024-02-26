//
//  BookDetailsView.swift
//  Books
//
//  Created by Alex on 23.02.2024.
//

import SwiftUI

protocol BookDetailsViewVMP {
    var carouselViewConfig: CarouselView.Config { get }
    var listViewConfig: ListView.Config { get }
    var labelsViewConfig: LabelsView.Config { get }
    var textsViewConfig: TextsView.Config { get }
    
    func backButtonAction()
}

struct BookDetailsView: View {
    
    @ObservedObject var viewModel: BookDetailsViewModel
    
    var body: some View {
        VStack {
            CarouselView(config: viewModel.carouselViewConfig)
            
            VStack(alignment: .leading, spacing: 10) {
                ScrollView {
                    LabelsView(config: viewModel.labelsViewConfig)
                    TextsView(config: viewModel.textsViewConfig)
                    ListView(config: viewModel.listViewConfig)
                        .padding(.leading, 16)
                    
                    Text("Read now")
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .padding(.horizontal, 48)
                        .background(Color.customLightPink)
                        .cornerRadius(30)
                    
                    Spacer()
                }
            }
            .background(Color.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        }
        .background(Color.violetDetails)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewModel.backButtonAction()
                }) {
                    Image("back_arrow")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(Color.violetDetails, for: .navigationBar)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
