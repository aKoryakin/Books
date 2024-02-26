//
//  LibraryView.swift
//  Books
//
//  Created by Alex on 21.02.2024.
//

import SwiftUI

protocol LibraryViewVMP {
    var listViewConfigs: [ListView.Config] { get }
    var sliderViewConfig: SliderView.Config { get }
}

struct LibraryView: View {
    
    @ObservedObject var viewModel: LibraryViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
//            VStack(alignment: .leading, spacing: 24) {
                SliderView(config: viewModel.sliderViewConfig)
                    .frame(height: 200)
                    .padding(.top, 16)
                    .clipped()
//            }
            
            
            VStack(alignment: .leading, spacing: 24) {
                ForEach(viewModel.listViewConfigs, id: \.title) { listViewConfig in
                    ListView(config: listViewConfig)
                }
            }
            .padding(.leading, 16)
            .padding(.vertical, 16)
        }
        .clipped()
        .background(Color.mainBlack)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Library")
                    .font(.customFont(font: .nunitoSans, style: .bold, size: .s20))
                    .foregroundColor(.customPink)
            }
        }
        .toolbarBackground(Color.mainBlack, for: .navigationBar)
    }
}
