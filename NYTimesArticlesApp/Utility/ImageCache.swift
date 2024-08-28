//
//  ImageCache.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
import UIKit
final class ImageCache {
    
    //Private Queue to manage cache operations
    private static let cacheQueue = DispatchQueue(label: "com.NYTimesArticlesApp.ImageCache.queue",
                                                  qos: .userInitiated,
                                                  attributes: .concurrent)
    
    //NSCache instance
    private static let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.name = "com.NYTimesArticlesApp.ImageCache"
        return cache
    }()
    //store image in the cache
    static func cacheImage(_ image: UIImage, forKey key: String) {
        cacheQueue.async(flags: .barrier) {
            imageCache.setObject(image, forKey: key as NSString)
        }
    }
   //retrieve from cache
    static func cachedImage(forKey key: String) -> UIImage? {
        return cacheQueue.sync {
            imageCache.object(forKey: key as NSString)
        }
    }
    //clear cache
    static func clearCache() {
        cacheQueue.async(flags: .barrier){
            imageCache.removeAllObjects()
        }
    }
    //load either from cache if not available then fetch from network
    static func loadImage(from url: URL, completion: @escaping(UIImage?) -> Void) {
        
        if let cachedImage = cachedImage(forKey: url.absoluteString) {
            if Thread.isMainThread {
                completion(cachedImage)
            } else {
                DispatchQueue.main.async {
                    completion(cachedImage)
                }
            }
            
            return
        }
        
        //download from network
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            // cache image
            cacheImage(image, forKey: url.absoluteString)
            
            //Main thread to return image
            DispatchQueue.main.async {
                completion(image)
            }
        }
        dataTask.resume()
        
    }
}
