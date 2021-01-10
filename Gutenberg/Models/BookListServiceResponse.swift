//
//  BookServiceResponse.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import Foundation

struct BookListServiceResponse: Decodable {
    let count: Int
    let nextBookFetchUrl: String?
    let previousBookFetchUrl: String?
    let books: [Book]
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case nextBookFetchUrl = "next"
        case previousBookFetchUrl = "previous"
        case books = "results"
    }
}
