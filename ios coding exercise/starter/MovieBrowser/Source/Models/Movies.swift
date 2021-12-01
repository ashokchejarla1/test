//
//  Movie.swift
//  MovieBrowser
//
//  Created by Ashok on 11/30/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Movies : Codable {
    var page : Int?
    var results : [Movie]?
}

struct Movie : Hashable,Codable {
    var adult : Bool?
    var backdropPath : String?
    var genreIds : [Int]
    var id : Int?
    var originalLanguage : String?
    var originalTitle : String?
    var overview : String?
    var popularity : Double?
    var posterPath : String?
    var releaseDate : String?
    var title : String?
    var video : Bool?
    var voteAverage : Float?
    var voteCount : Int?
}
