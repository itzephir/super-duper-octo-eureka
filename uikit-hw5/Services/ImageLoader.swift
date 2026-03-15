//
//  ImageLoader.swift
//  uikit-hw5
//

import UIKit

final class ImageLoader: @unchecked Sendable {
    static let shared = ImageLoader()

    private let cache = NSCache<NSURL, UIImage>()

    private nonisolated init() {}

    nonisolated func loadImage(from url: URL, completion: @escaping @Sendable (UIImage?) -> Void) {
        DispatchQueue.main.async { [weak self] in
            if let cached = self?.cache.object(forKey: url as NSURL) {
                completion(cached)
                return
            }
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self?.cache.setObject(image, forKey: url as NSURL)
            completion(image)
        }.resume()
    }
}
