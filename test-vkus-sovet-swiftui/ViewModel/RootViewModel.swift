//
//  RootViewModel.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//

import Foundation
import SwiftUI

final class RootViewModel: ObservableObject {
    @Published var menuItems: [Menu] = []
    @Published var selectedCategoryIndex: Int = 0
    @Published var selectedMenuID: String = "21"
    @Published var categoryItems: [Product] = []
    @Published var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Add recieved data to array of categories
    func fetchData() {
        APIClient.shared.sendPostRequest { response in
            DispatchQueue.main.async {
                if let response = response {
                    self.menuItems = response.menuList
                }
            }
        }
    }
    
    func fetchItems() {
        APIClient.shared.sendPostRequestForMenu(forMenuId: selectedMenuID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseData):
                    self?.categoryItems = responseData.menuList
                case .failure(let error):
                    print("Error while fetching data: \(error)")
                }
            }
        }
    }
}

