//
//  MenuModel.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//

import Foundation

struct Menu: Codable {
    let menuID: String
    let image: String
    let name: String
    let subMenuCount: Int
}

struct MenuResponse: Codable {
    let status: Bool
    let menuList: [Menu]
}

