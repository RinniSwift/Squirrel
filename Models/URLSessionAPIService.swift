//
//  File.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/27/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

class URLSessionAPIService {
    
    func getCategory() {
        let endPoint: String = "https://squirrelaway.herokuapp.com/resources"
        guard let url = URL(string: endPoint) else {
            print("error catching url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error calling end point")
                return
            }
            
            guard let dataResponse = data else {
                print("error recieving data")
                return
            }
            do {
                let responseObject = try (JSONSerialization.jsonObject(with: dataResponse, options:[.allowFragments])) as! [String]
                print(responseObject)
            } catch let jsonError {
                print(jsonError)
                print(jsonError.localizedDescription)
                print(String(data: dataResponse, encoding: String.Encoding.utf8) as Any)
            }
        }
        task.resume()
    }
    
    
    func getItemInCat() {
        let endPoint: String = "https://squirrelaway.herokuapp.com/Make%20School"
        guard let url = URL(string: endPoint) else {
            print("error catching url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error calling end point")
                return
            }
            
            guard let dataResponse = data else {
                print("error recieving data")
                return
            }
            
            do {
                let responseObject = try (JSONSerialization.jsonObject(with: dataResponse, options:[]))
                if let respObject = responseObject as? [String: Any] {
                    print(respObject)
                }
                print(responseObject)
            } catch let jsonError {
                print(jsonError)
                print(jsonError.localizedDescription)
                print(String(data: dataResponse, encoding: String.Encoding.utf8) as Any)
            }
        }
        task.resume()
    }
    
    
    func postAuth() {
        let endPoint = "https://squirrelaway.herokuapp.com/login"
        guard let url = URL(string: endPoint) else {
            print("error catching url")
            return
        }
        
        let json = ["username": "AFJR", "password": "1234"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let dataResponse = data else {
                print("error receiving data")
                return
            }
            
            guard error == nil else {
                print("error calling endpoint")
                return
            }
            
            let responseObject = try? JSONSerialization.jsonObject(with: dataResponse, options: [])
            if let responseObject = responseObject as? [String: String] {
                print(responseObject)
            }
        }
        task.resume()
    }
}
