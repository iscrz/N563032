//
//  ProductCellView.swift
//  N563032
//
//  Created by Isaac on 7/9/17.
//  Copyright © 2017 Isaac. All rights reserved.
//

import Foundation
import UIKit

class ProductCellView: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var priceLabel: UILabel?
    
    var product: Product? {
        
        didSet {
            
            guard let product = product else {
                return
            }
            
            nameLabel?.text             = product.name
            priceLabel?.text            = product.displayPrice
            contentView.backgroundColor = product.color
            imageView?.downloadedFrom(url: product.thumbnail, contentMode: .scaleAspectFill)
        }
    }
    
}
