//
//  NYTAPI.swift
//  NYTimesGroupProj
//
//  Created by Jocelyn Boyd on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

//MARK: -- New York Times Categories
struct NYTListName: Codable {
    let results: [ListNameResult]
}

struct ListNameResult: Codable {
    let listName: String
    let displayName: String
    let listNameEncoded: String
    
    private enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
        
    }
}

struct NYTimeBookWrapper: Codable {
    let results: Results
}

struct Results: Codable {
    let books: [NYTimeBook]
}

struct NYTimeBook: Codable {
    let weeks_on_list: Int
//    let publisher: Publisher
    let description: String
    let title: String
    let author: String
    let book_image: String
    let amazon_product_url: String

}


