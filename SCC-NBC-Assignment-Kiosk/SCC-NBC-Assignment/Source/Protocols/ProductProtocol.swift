//
//  ProductProtocol.swift
//  SCC-NBC-Assignment
//
//  Created by Joon Baek on 2023/12/06.
//

protocol ProductProtocol: Any {
    var name: String? { get set }
    var price: Int? { get set }
    var description: String? { get set }
}
