//
//  CardInfo.swift
//  Squirrel
//
//  Created by Rinni Swift on 3/9/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation


class CardInfo: NSObject, Codable {
    
    var name: String
    var notes: String
    var url: String
    var image: String?
    var category: String
    
    init(name: String, notes: String, url: String, category: String) {
        self.name = name
        self.notes = notes
        self.url = url
        self.category = category
    }
    
    init(name: String, notes: String, url: String, image: String, category: String) {
        self.name = name
        self.notes = notes
        self.url = url
        self.image = image
        self.category = category
    }
}
