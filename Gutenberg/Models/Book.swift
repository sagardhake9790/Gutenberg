//
//  Book.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import Foundation

struct Book: Decodable {
    let id: Int
    let title: String?
    let subjects: [String]
    let mediaType: String?
    let languages: [String]
    let bookShelves: [String]
    let authors: [Author]
    let downloadCount: Int
    let bookFormatUrl: BookFormatURL?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case subjects = "subjects"
        case mediaType = "media_type"
        case languages = "languages"
        case bookShelves = "bookshelves"
        case authors = "authors"
        case downloadCount = "download_count"
        case bookFormatUrl = "formats"
    }
}

struct Author: Decodable {
    let name: String?
    let birthYear: Int?
    let deathYear: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}

struct BookFormatURL: Decodable {
    let textUrl: String?
    let htmlUrl: String?
    let pdfUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case textUrl = "text/plain; charset=us-ascii"
        case htmlUrl = "text/html; charset=utf-8"
        case pdfUrl = "application/pdf"
    }
}
