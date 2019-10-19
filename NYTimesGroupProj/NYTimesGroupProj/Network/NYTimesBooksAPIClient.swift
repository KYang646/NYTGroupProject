//
//  NYTimesBooksAPIClient.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

final class NYTimesBooksAPIClient {
    private init() {}
    
    private var apiKey = "D8XGY4XP3kgNv2V9li2f192mdAOKesVe"
    static let shared = NYTimesBooksAPIClient()
    
    func getCategories(categoryName: String, completionHandler: @escaping (Result<[SearchResult], AppError>) -> Void) {
         let urlStr = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=\(apiKey)&list=\(categoryName)"
         print(urlStr)
         guard let url = URL(string: urlStr) else {
             completionHandler(.failure(.badURL))
             return
         }
         
         NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
             switch result {
             case .failure(let error) :
                 completionHandler(.failure(error))
             case .success(let data):
                 do {
                     let NYTimeWrapper = try JSONDecoder().decode(NYTime.self, from: data)
                    completionHandler(.success(NYTimeWrapper.results))
                 } catch {
                     completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                 }
             }
         }
     }
}
