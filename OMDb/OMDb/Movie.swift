//
//  Movie.swift
//  OMDb
//
//  Created by Mariana Alvarez on 04/03/16.
//  Copyright © 2016 Mariana Alvarez. All rights reserved.
//

import Foundation

class Movie: NSObject {
    
    var id: String!
    var title: String!
    var year: String!
    var genre: String!
    var director: String!
    var plot: String!
    var language: String!
    var country: String!
    
    override init() {
        
    }
    
    init(title: String, year: String, id: String) {
        self.title = title
        self.year = year
        self.id = id
    }
    
}
