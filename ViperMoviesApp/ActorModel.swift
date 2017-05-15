//
//  CastModel.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 05.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation


struct ActorModel {
    
    var actorCharacter: String?
    var actorId: Int?
    var actorName: String?
    var actorPathUrl: String?
    
    //Details
    var biography: String?
    var birthday: String?
    var placeOfBirth: String?
    var imdbId: String?
    
    init(actorCharacter: String, actorId: Int, actorName: String, actorPathUrl: String) {
        self.actorCharacter = actorCharacter
        self.actorId = actorId
        self.actorName = actorName
        self.actorPathUrl = actorPathUrl
    }
    
    
    init(biography: String, birthday: String, placeOfBirth: String, imdbId: String) {
        self.biography = biography
        self.birthday = birthday
        self.placeOfBirth = placeOfBirth
        self.imdbId = imdbId
    }
    
    var photoURL: NSURL {
        return movieImageURL()
    }
    
    private func movieImageURL() -> NSURL {
        return NSURL(string: "https://image.tmdb.org/t/p/w300\(actorPathUrl!)")!
    }
    
}
