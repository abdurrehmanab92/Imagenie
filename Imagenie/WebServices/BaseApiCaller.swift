//
//  BaseApiCaller.swift
//  Imagenie
//
//  Created by Abdur Rehman on 29/06/2021.
//

import Foundation
class BaseURLSession{
     let session = URLSession.shared
     func get(_ url:String,completionHandler: @escaping (Data?,Error?) -> Void){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
        task.resume()
    }
}
