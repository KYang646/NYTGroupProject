//
//  FavoriteBooksPersistenceHelper.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import Foundation

struct FavoriteBookPersistenceHelper {
    
    static let manager = FavoriteBookPersistenceHelper()

    func save(newBook: NYTimeBook) throws {
        try persistenceHelper.save(newElement: newBook)
    }

    func getBooks() throws -> [NYTimeBook] {
        return try persistenceHelper.getObjects()
    }

    private let persistenceHelper = PersistenceHelper<NYTimeBook>(fileName: "mySavedBooks.plist")
    
    private init() {}
}

