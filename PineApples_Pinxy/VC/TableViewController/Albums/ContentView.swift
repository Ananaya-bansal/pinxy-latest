//
//  ContentView.swift
//  PineApples_Pinxy
//
//  Created by Ananaya on 01/05/24.
//

import SwiftUI

struct Data: Identifiable, Equatable {
    let id: UUID = .init()
    let value: String
}

struct ContentView: View {
    var images: [String] // Array of image names
    @Namespace var namespace // Namespace for matched geometry effects
    let dataList: [Data] // Data model array
    
    // State variables
    @State private var selectedItem: Data?
    @State private var position = CGSize.zero
    
    // Initialize ContentView with an array of image names
    init(images: [String]) {
        self.images = images
        // Create Data instances from image names
        self.dataList = images.map { Data(value: $0) }
    }
    
    var body: some View {
        ZStack {
            // Main content
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2),
                    GridItem(.flexible(minimum: 100, maximum: 200), spacing: 2)
                ], spacing: 2) {
                    ForEach(dataList) { data in
                        Image(data.value)
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .matchedGeometryEffect(id: data.id, in: namespace, isSource: selectedItem == nil)
                            .zIndex(selectedItem == data ? 1 : 0)
                            .onTapGesture {
                                position = .zero
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                    selectedItem = data
                                }
                            }
                    }
                }
                .padding(2)
            }
//            // Black background with conditional opacity
//            Color.black.opacity(selectedItem == nil ? 0 : 0.6)
//                .edgesIgnoringSafeArea(.all)
//                .opacity(selectedItem == nil ? 0 : 1)
            // Full-screen view of selected image
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(selectedItem == nil ? 0 : min(1, max(0, 1 - abs(Double(position.height) / 800))))
            
            if let selectedItem {
                Image(selectedItem.value)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .matchedGeometryEffect(id: selectedItem.id, in: namespace, isSource: selectedItem != nil)
                    .zIndex(2)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            self.selectedItem = nil
                        }
                    }
                    .offset(position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.position = value.translation
                            }
                            .onEnded { value in
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                    if 200 < abs(self.position.height) {
                                        self.selectedItem = nil
                                    } else {
                                        self.position = .zero
                                    }
                                }
                            }
                    )
            }
        }
    }
}
