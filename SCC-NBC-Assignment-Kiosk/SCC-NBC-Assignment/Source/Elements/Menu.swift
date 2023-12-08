//
//  Menu.swift
//  SCC-NBC-Assignment
//
//  Created by Joon Baek on 2023/12/07.
//

import Foundation

enum viewType {
    case categories
    case detail
}

class Menu {
    
    var categories: [TitleDisplayable]
    var products: [ProductInfoProtocol]
    
    init(categories: [TitleDisplayable], products: [ProductInfoProtocol]) {
        self.categories = categories
        self.products = products
        
    }
}

extension Menu {
    func printMenu(viewType: viewType) {
        print("[ SHAKESHACK MENU ]")
        
        switch viewType {
        case .categories:
            for (index, category) in categories.enumerated() {
                print("\(index + 1). \(category.name ?? "") | \(category.description ?? "")")
            }
        case .detail:
            for (index, product) in products.enumerated() {
                print("\(index + 1). \(product.name ?? "") | \(product.price ?? 0), | \(product.description ?? "")")
                print("0. 종료")
            }
        }
    }
    
    func selectProduct(at index: Int) -> ProductInfoProtocol? {
        if index >= 0 && index < products.count {
            return products[index]
        }
        return nil
    }
}
