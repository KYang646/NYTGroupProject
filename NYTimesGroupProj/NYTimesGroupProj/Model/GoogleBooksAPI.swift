//
//  GoogleBooksAPI.swift
//  NYTimesGroupProj
//
//  Created by Jocelyn Boyd on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

struct GoogleBook: Codable {
    let items: [Item]
}

struct Item: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let thumbnail: String
}



