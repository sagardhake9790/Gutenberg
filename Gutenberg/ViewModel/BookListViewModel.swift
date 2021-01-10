//
//  BookListViewModel.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import Foundation

class BookListViewModel {
                
    //MARK: Fetch Album Data
    
    func fetchBookListByCaregory(url: String, success: @escaping (BookListServiceResponse) -> (),failure: @escaping (Error) -> ()) {
        NetworkService().getRequest(url: url, success: { (data) in
           if let data = data,
                let bookListServiceResponse = try? JSONDecoder().decode(BookListServiceResponse.self, from: data) {
                success(bookListServiceResponse)
            }
        }) { (error) in
            failure(error)
        }
    }
}
