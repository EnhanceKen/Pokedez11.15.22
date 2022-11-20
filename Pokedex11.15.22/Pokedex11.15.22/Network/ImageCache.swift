//
//  ImageCache.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/18/22.
//

import Foundation

final class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache: NSCache<NSNumber, NSData> = NSCache<NSNumber, NSData>()
    
    private init() { }
    
}

extension ImageCache {
    
    func set(data: Data, id: Int) {
        let key = NSNumber(value: id)
        let object = NSData(data: data)
        self.cache.setObject(object, forKey: key)
    }
    
    func get(id: Int) -> Data? {
        let key = NSNumber(value: id)
        guard let object = self.cache.object(forKey: key) else { return nil }
        
        return Data(referencing: object)
    }
    
}
