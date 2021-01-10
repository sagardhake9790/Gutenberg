//
//  NetworkManager.swift
//  Gutenberg
//
//  Created by Sagar Dhake on 10/01/21.
//

import Foundation

class NetworkService {
    
    static let networkService = NetworkService()
    
    func getRequest(url:String, success: @escaping (Data?) -> (),failure: @escaping (Error) -> ()) {
        let url = URL(string: url)!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            failure(error)
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                200 == httpResponse.statusCode else {
            return
          }
          
          success(data)
        })
        task.resume()
    }
}
