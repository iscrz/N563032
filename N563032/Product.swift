//
//  Product.swift
//  N563032
//
//  Created by Isaac on 7/9/17.
//  Copyright © 2017 Isaac. All rights reserved.
//

import Foundation
import UIKit

struct Product {
    
    let name: String
    let thumbnail: URL
    let price: Int
    let color: UIColor
    
    init(name: String = "Product", thumbnail: String = "https://placehold.it/100x100", price:Int = 100, color: UIColor = .green) {
        self.name = name
        self.thumbnail = URL(string: thumbnail)!
        self.price = price
        self.color = color
    }
    
    var displayPrice: String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        guard let priceString = numberFormatter.string(for: Float(price) / 100.0) else {
            return "Price not found"
        }
        
        return priceString
    }
    

}
