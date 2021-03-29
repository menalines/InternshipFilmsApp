//
//  ImageView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 29.03.21.
//

import Combine
import UIKit
import SwiftUI

var imageCache = NSCache<NSString, UIImage>()

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()

    init(withURL url: String?) {
        guard let url = url else {
            imageLoader = ImageLoader(urlString: "https://seohotmix.ru/wp-content/uploads/2019/10/Screenshot_1-1-4.png") 
            return 
        }

        imageLoader = ImageLoader(urlString: "https://image.tmdb.org/t/p/w500/\(url)")
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString: String) {
        if let cacheImage = imageCache.object(forKey: urlString as NSString),
           let data = cacheImage.pngData() {
            DispatchQueue.main.async {
                self.data = data
            }
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: urlString as NSString)
            }
            
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
