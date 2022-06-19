//
//  ImageLoader.swift
//  Gymondo-Assestment
//
//  Created by Erfan Andesta on 3/21/1401 AP.
//

import Foundation
import UIKit.UIImage
import Combine

final class ImageLoaderService: ImageLoaderServiceType {

    private let cache: ImageCacheType = ImageCache()

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache.image(for: url) {
            return .just(image)
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache.insertImage(image, for: url)
            })
            .print("Image loading \(url):")
            .eraseToAnyPublisher()
    }
}
