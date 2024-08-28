//
//  ImageCacheTests.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import XCTest
@testable import NYTimesArticlesApp
class ImageCacheTests: XCTestCase {
    
    func testImageCaching() {
        let imageKey = "testImageKey"
        let testImage = UIImage(systemName: "star.fill")!
        ImageCache.cacheImage(testImage, forKey: imageKey)
        let cachedImage = ImageCache.cachedImage(forKey: imageKey)
        
        // Assert
        XCTAssertNotNil(cachedImage, "Image should be retrieved from the cache")
        XCTAssertEqual(cachedImage, testImage, "Cached image should match the saved image")
    }
    
    func testCacheMiss() {
        let nonExistentKey = "nonExistentKey"
        let cachedImage = ImageCache.cachedImage(forKey: nonExistentKey)
        // Assert
        XCTAssertNil(cachedImage, "Cache miss should return nil for a non-existent key")
    }
    
    func testImageCachingAndRetrieval() {
        let imageKey = "testImageKey"
        let testImage = UIImage(systemName: "star.fill")!
        ImageCache.cacheImage(testImage, forKey: imageKey)
        
        //clearing image
        let imageView = UIImageView()
        imageView.image = nil
        let cachedImage = ImageCache.cachedImage(forKey: imageKey)
        //Assert
        XCTAssertNotNil(cachedImage, "Image should be retrieved from the cache")
        XCTAssertEqual(cachedImage, testImage, "Fetched Image should match the cached image")
    }
    
}
