//
//  BookCategory.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import Foundation

struct BookCategory {
    let category: String;
    let image: String
    
    init(category: String, image: String) {
        self.category = category;
        self.image = image;
    }
}
