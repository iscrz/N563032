//
//  CollectionViewController.swift
//  N563032
//
//  Created by Isaac on 7/9/17.
//  Copyright © 2017 Isaac. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    
    var products: [Product] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Products"
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRotate(notification:)), name: .UIDeviceOrientationDidChange, object: nil)
        
        do {
            try ProductLoader.load(json: "products") { products in
                self.products = products
            }
        } catch {
            
            let alert = UIAlertController(title: "Error Loading JSON", message: error.localizedDescription, preferredStyle: .alert)
            
            present(alert, animated: true, completion: nil)
        } 
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetLayout()
    }
    
    //MARK: Handle Rotation
    
    @objc func onRotate(notification: NSNotification) {
        resetLayout()
    }
    
    func resetLayout() {
        
        let width = (view.bounds.width / 3)
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: width, height: width)
            flow.invalidateLayout()
        }
    }
    
    //MARK: UICollectionViewDelegates
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCellView else {
            return UICollectionViewCell()
        }
        
        cell.product = products[safe: indexPath.row]
        
        return cell
        
    }
    
    //MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
            case "DisplayProduct":
                if let view = segue.destination as? ProductViewController,
                   let cell = sender as? ProductCellView,
                   let product = cell.product {
                    view.product = product
                }
        default: break
        }
    }
}


