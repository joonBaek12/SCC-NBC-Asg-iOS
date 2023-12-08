//
//  Categories.swift
//  SCC-NBC-Assignment
//
//  Created by Joon Baek on 2023/12/08.
//

import Foundation

class Categories: TitleDisplayable {
    var name: String?
    var description: String?
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
