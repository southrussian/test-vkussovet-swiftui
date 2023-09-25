//
//  APIClient.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//


import SwiftUI

final class APIClient {
    static let shared = APIClient()
    private let cache = NSCache<NSString, UIImage>()
    static let mainUrl = "https://vkus-sovet.ru/api"
    private let urlForMenu = mainUrl + "/getMenu.php"
    private let urlForProduct = mainUrl + "/getSubMenu.php?menuID="
    
    private init() {
        
    }
    // Function to get Categories from API
    func sendPostRequest(completion: @escaping (MenuResponse?) -> Void) {
        guard let url = URL(string: urlForMenu) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer YourAccessToken", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "key1": "value1",
            "key2": "value2"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("Error: \(error)")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error: \(error)")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let responseData = try JSONDecoder().decode(MenuResponse.self, from: data)
                    completion(responseData)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    // Function to get Image from URL
    func downloadImage(fromUrlString urlString: String, completed: @escaping (UIImage?) -> Void) {
//
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
        
    }
    
    // Function to get Items of the selected category
    func sendPostRequestForMenu(forMenuId menuID: String, completion: @escaping(Result<ProductResponse, Error>) -> Void) {
        guard let url = URL(string: urlForProduct + "\(menuID)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "nil", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(ProductResponse.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

