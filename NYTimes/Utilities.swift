//
//  Utilities.swift
//  NYCAssessment
//
//  Created by Paurush on 28/06/19.
//  Copyright © 2019 Paurush. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    func loadImage(urlString: String, completion: (() -> ())? = nil) {
        image = nil
        
        let urlKey = urlString as NSString
        
        if let cachedItem = imageCache.object(forKey: urlKey) {
            image = cachedItem
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlKey)
                    self?.image = image
                    completion?()
                }
            }
            
        }).resume()
    }
}
