//
//  FrozenCustard.swift
//  SCC-NBC-Assignment
//
//  Created by Joon Baek on 2023/12/07.
//

import Foundation

class FrozenCustard: ProductProtocol {
    var name: String?
    var price: Int?
    var description: String?
    
    init(name: String, price: Int, description: String) {
        self.name = name
        self.price = price
        self.description = description
    }
}
