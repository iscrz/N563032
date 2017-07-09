//
//  ProductLoader.swift
//  N563032
//
//  Created by Isaac on 7/9/17.
//  Copyright © 2017 Isaac. All rights reserved.
//

import Foundation
import UIKit

enum ProductLoaderError: Error {
    case fileNotFound
    case invalidSchema
}

class ProductLoader {
    
    static func load(json named: String, complete: ([Product]) -> Void) throws {
        
        guard let path = Bundle.main.path(forResource: named, ofType: "json") else {
            throw ProductLoaderError.fileNotFound
        }
        
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let object = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
        
        guard let dictionary = object as? [String : AnyObject],
              let objects = dictionary["products"] as? [[String : AnyObject]] else {
            throw ProductLoaderError.invalidSchema
        }
        
        let products = try objects.map { (obj) -> Product in
            
            guard let name = obj["name"] as? String,
                  let thumbnail = obj["thumbnail"] as? String,
                  let price: Int = obj["price"] as? Int,
                  let color: String = obj["color"] as? String else {
                    
                 throw ProductLoaderError.invalidSchema
            }
            
            
            let product = Product(name: name,
                                  thumbnail: thumbnail,
                                  price: price,
                                  color: UIColor(hex: color))
            return product
        }
        
        complete(products)
    }
    
}
