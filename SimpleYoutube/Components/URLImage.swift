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
            GeometryReader { geometry in
                ProgressView()
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .onAppear(perform: loadImage)
            }
        }
    }
    
    private func loadImage() {
        guard let url = url else {
            image = UIImage(named: "error-icon")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                image = UIImage(named: "error-icon")
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
