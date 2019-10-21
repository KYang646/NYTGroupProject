//
//  GoogleBooksAPIClient.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

final class GoogleBooksAPIClient {
    private init() {}
    
    static let shared = GoogleBooksAPIClient()
    
    func getGoogleBooks(isbn10: String, completionHandler: @escaping (Result<GoogleBook, AppError>) -> Void) {
         let urlStr = "https://www.googleapis.com/books/v1/volumes?q=+isbn:\(isbn10)"
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
                     let bookWrapper = try JSONDecoder().decode(GoogleBook.self, from: data)
                    completionHandler(.success(bookWrapper))
                 } catch {
                     completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                 }
             }
         }
     }
}
