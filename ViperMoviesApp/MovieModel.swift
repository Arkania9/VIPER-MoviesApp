//
//  PopularModel.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 03.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

struct MovieModel {
    
    var posterPath: String?
    var overview: String?
    var title: String?
    var vote: Double?
    var id: Int?
    var totalPages: Int?
    
    //Details
    var boxoffice: String?
    var duration: String?
    var tagline: String?
    var releaseDate: String?
    var category: String?
    var production: String?
    
    init(posterPath: String, overview: String, title: String, vote: Double, id: Int) {
        self.posterPath = posterPath
        self.overview = overview
        self.title = title
        self.vote = vote
        self.id = id
    }
    
    init(boxoffice: String, duration: String, tagline: String, releaseDate: String, category: String, production: String) {
        self.boxoffice = boxoffice
        self.duration = duration
        self.tagline = tagline
        self.releaseDate = releaseDate
        self.category = category
        self.production = production
    }
    
    init(title: String, releaseDate: String, posterPath: String, movieId: Int, vote: Double, overview: String) {
        self.title = title
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.id = movieId
        self.vote = vote
        self.overview = overview
    }
    
    var photoURL: NSURL {
        return movieImageURL()
    }

    private func movieImageURL() -> NSURL {
        return NSURL(string: "https://image.tmdb.org/t/p/w300\(posterPath!)")!
    }
    



    
}
