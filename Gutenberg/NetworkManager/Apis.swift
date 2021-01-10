//
//  Apis.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import Foundation

let appUrl = "http://skunkworks.ignitesol.com:8000/"

struct Apis {
    
    static let getBooksByCategory = appUrl + "books?topic=%@"
    
    static let getBooksBySearchString = appUrl + "books?topic=%@&search=%@"
}
