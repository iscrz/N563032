//
//  N563032Tests.swift
//  N563032Tests
//
//  Created by Isaac on 7/9/17.
//  Copyright © 2017 Isaac. All rights reserved.
//

import XCTest
@testable import N563032

class N563032Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProduct() {
        let product = Product(name: "Test", price: 12345, color: .black)
        
        XCTAssert(product.name == "Test")
        XCTAssert(product.displayPrice == "$123.45")
        XCTAssert(product.color == .black)
    }
    
    func testGoodProductJSOn() {
        
        do {
            try ProductLoader.load(json: "test-good", complete: { (products) in
                XCTAssert(products.count == 1)
                
                if let product = products[safe: 0] {
                    XCTAssert(product.name == "product name")
                    XCTAssert(product.thumbnail.absoluteString == "https://via.placeholder.com/350/0061ff/75a9ff?text=FPO%20A")
                    XCTAssert(product.price == 1000)
                    XCTAssert(product.displayPrice == "$10.00")

                    var red: CGFloat = 0.0
                    var green: CGFloat = 1.0
                    var blue: CGFloat = 1.0
                    product.color.getRed(&red, green: &green, blue: &blue, alpha: nil)
                    XCTAssert(red == 1.0)
                    XCTAssert(green == 0.0)
                    XCTAssert(blue == 0.0)
                    
                } else {
                    XCTAssert(false)
                }
            })
        } catch {
           print(error)
           XCTAssert(false)
        }
    }
    
    func testBadProductJSOn() {
        
        do {
            try ProductLoader.load(json: "test-bad", complete: { (products) in
                XCTAssert(false)
            })
        } catch ProductLoaderError.invalidSchema {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testMissingProductJSOn() {
        
        do {
            try ProductLoader.load(json: "null", complete: { (products) in
                XCTAssert(false)
            })
        } catch ProductLoaderError.fileNotFound {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testCollectionExtensions() {
        
        let array = [0,1,2,3,4,5,6,7]
        
        XCTAssert(array[safe: 0] == 0) // in bounds
        XCTAssert(array[safe: 1] == 1) // in bounds
        XCTAssert(array[safe: 8] == nil) // out of bounds
        
       
    }
    
    func testColorExtentions() {
        let color = UIColor(hex: "00ff00")
        var red: CGFloat = 2
        var green: CGFloat = 2
        var blue: CGFloat = 2
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        XCTAssert(red == 0.0)
        XCTAssert(green == 1.0)
        XCTAssert(blue == 0.0)
    }
}
