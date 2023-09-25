//
//  ProductModel.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//

import Foundation

struct Product: Codable {
    let id: String
    let image: String
    let name: String
    let content: String
    let price: String
    let weight: String
    let spicy: String?
}

struct ProductResponse: Codable {
    let status: Bool
    let menuList: [Product]
}
