//
//  URLImage.swift
//  SimpleYoutube
//
//  Created by Charlie Irawan on 4/1/23.
//

import SwiftUI

struct URLImage: View {
    let url: URL?
    @State private var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        guard let safeUrl = url else {
            image = UIImage(named: "error-icon")
            return
        }
        URLSession.shared.dataTask(with: safeUrl) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                image = UIImage(data: data)
            }
        }.resume()
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: URL(string: "https://img.youtube.com/vi/4HcSMGobl94/maxresdefault.jpg"))
    }
}
