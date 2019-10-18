//
//  NYTAPI.swift
//  NYTimesGroupProj
//
//  Created by Jocelyn Boyd on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

//MARK: -- Endpoint Categories
/*
 -------FICTION-----------------
 combined-print-and-e-book-fiction
 hardcover-fiction
 paperback-trade-nonfiction
 -------NONFICTION--------------
 combined-print-and-e-book-nonfiction
 hardcover-nonfiction
 paperback-nonfiction
 advice-how-to-and-miscellanous
 -------CHILDREN’S--------------
 childrens-middle-grade-hardcover
 picture-books
 series-books
 young-adult-hardcover
*/

//MARK: -- New York Times
struct NYTime: Codable {
    let results: [SearchResult]
  
}
// MARK: -- SearchResults
struct SearchResult: Codable {
    let displayName: String
    let weeksOnList: Int
    let amazonProductURL: String
    let bookDetails: [BookDetail]
  
    private enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case weeksOnList = "weeks_on_list"
        case amazonProductURL = "amazon_product_url"
        case bookDetails = "book_details"
    }
}
// MARK: - BookDetail
struct BookDetail: Codable {
    let title: String
    let bookDetailDescription: String
    let author: String
    let primaryIsbn13, primaryIsbn10: String
  
    private enum CodingKeys: String, CodingKey {
        case title
        case bookDetailDescription = "description"
        case author
        case primaryIsbn13 = "primary_isbn13"
        case primaryIsbn10 = "primary_isbn10"
    }
}
