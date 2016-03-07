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
    var director: String?
    var plot: String?
    var language: String?
    var country: String?
    var runtime: String?
    var poster: String?
    
    override init() {
        
    }
    
}
