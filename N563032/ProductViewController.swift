//
//  ProductViewController.swift
//  N563032
//
//  Created by Isaac on 7/9/17.
//  Copyright © 2017 Isaac. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UIViewController {
    
    var product: Product = Product()
    
    @IBOutlet var imageView: UIImageView?
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = product.name
        view.backgroundColor = product.color
        imageView?.downloadedFrom(url: product.thumbnail, contentMode: .scaleAspectFill)
    }
}
