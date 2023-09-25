//
//  ImageLoader.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//


import Foundation

import SwiftUI

final class ImageService: ObservableObject {
    
    @Published var image: Image? = nil
    
    // function to load image from url
    func loadImage(fromUrlString urlString: String) {
        APIClient.shared.downloadImage(fromUrlString: "https://vkus-sovet.ru" + urlString) { uiImage in
            guard let uiImage = uiImage else {
                return
            }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

struct RemoteImage: View {
    var image: Image?
    var body: some View {
        image?.resizable() ?? Image("kotik").resizable()
            
    }
}

struct RemoteImageView: View {
    @StateObject var imageLoader = ImageService()
    let urlString: String
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.loadImage(fromUrlString: urlString)
            }
    }
}
