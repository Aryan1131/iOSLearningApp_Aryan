//
//  NetworkManager.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit

// MARK: 43 singleton class should be final->DONE
public final class NetworkManager {
    static let shared = NetworkManager()
    // MARK: 42 init should be private -> showing error
    private init() {}
    
    func fetchData<T: Decodable>(_ api: API,  completionHandler: @escaping (T) -> Void) {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.baseUrl
        components.path = api.path
        var urlQueryItems : [URLQueryItem] = []
        if let queryParams = api.queryParams {
            queryParams.forEach({
                element in
                let urlQueryItem = URLQueryItem(name: element.key, value: element.value)
                urlQueryItems.append(urlQueryItem)
            })
        }
        components.queryItems = urlQueryItems
        
        guard let url = components.url else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        fetchResponse(urlRequest, completionHandler: completionHandler)
        
    }
    
     func fetchData<T: Decodable>(_ urlString: String,  completionHandler: @escaping (T) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        fetchResponse(urlRequest, completionHandler: completionHandler)
    }
    
     func fetchResponse<T: Decodable>(_ urlRequest: URLRequest,  completionHandler: @escaping (T) -> Void) {
         // MARK: 47 improper spacing for ,->DONE
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data, resposone, error)-> Void in
            if error != nil {
                return
            }
            guard let data = data else {
                return
            }
            if let object = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async(execute: {
                    completionHandler(object)
                })
            } else {
                // MARK: 44 print and string in code ->DONE
                print(errorConstants.error)
            }
        }).resume()
    }
    
    func fetchImage(urlString: String, completionHandler: @escaping (UIImage)->()) {
        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
                if error != nil {
                    return
                }
            guard let data = data else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                completionHandler(image)
            }
        }).resume()
    }
}
