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
    
    
    // 'GET' request
    
    func getCategoryNames(completion: @escaping ([String]) -> ()) {
        
        let endPoint: String = "https://squirrelaway.herokuapp.com/resources"
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
                let responseObject = try (JSONSerialization.jsonObject(with: dataResponse, options:[.allowFragments])) as! [String]
                print(responseObject)
                completion(responseObject)
            } catch let jsonError {
                print(jsonError)
                print(jsonError.localizedDescription)
                print(String(data: dataResponse, encoding: String.Encoding.utf8) as Any)
            }
        }
        task.resume()
    }
    
    
    func getCategoryInfo(categoryPath: String, completion: @escaping ([String: [CardInfo]]) -> ()) {
        
        let concatStrPath = categoryPath.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        let endPoint: String = "https://squirrelaway.herokuapp.com/\(concatStrPath)"
        guard let url = URL(string: endPoint) else {
            print("error catching url")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            guard response != nil else {
                print("no response")
                return
            }
            guard let dataResponse = data else {
                print("error recieving data")
                return
            }
            let responseObject = try? JSONDecoder().decode([CardInfo].self, from: dataResponse)
            
            let complInfo = [categoryPath: responseObject]
            completion(complInfo as! [String : [CardInfo]])
        }
        task.resume()
    }
    
    
    // 'POST' request
    
    func postAuth(username: String, password: String) {
        let endPoint = "https://squirrelaway.herokuapp.com/login"
        guard let url = URL(string: endPoint) else {
            print("error catching url")
            return
        }
        
        let json = ["username": username, "password": password]
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
    
    func postNewCard(name: String, urll: String, notes: String, category: String, image: String) {
        let endPoint = "https://squirrelaway.herokuapp.com/resources"
        guard let url = URL(string: endPoint) else {
            print("error catching url")
            return
        }
        
        let json = ["name": name, "url": urll, "notes": notes, "category": category, "image": image]
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
