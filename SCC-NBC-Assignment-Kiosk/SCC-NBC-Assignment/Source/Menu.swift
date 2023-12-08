//
//  Menu.swift
//  SCC-NBC-Assignment
//
//  Created by Joon Baek on 2023/12/07.
//

import Foundation

class Menu {
    var products: [ProductInfoProtocol]
    
    init(products: [ProductInfoProtocol]) {
        self.products = products
    }
    
    func printMenu() {
        print("[ SHAKESHACK MENU ]")
        for (index, product) in products.enumerated() {
            print("\(index + 1). \(product.name ?? "") | \(product.price ?? 0) ")
        }
        print("0. 종료")
    }
    
    func selectProduct(at index: Int) -> ProductInfoProtocol? {
        if index >= 0 && index < products.count {
            return products[index]
        }
        return nil
    }
}
