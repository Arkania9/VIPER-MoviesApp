//
//  ActorInteractor.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 06.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit


class ActorInteractor: ActorInteractorProtocol {
    
    var actorDataManager: ActorDataManagerProtocol!
    var presenter: ActorPresenterProtocol!
    
    func downloadActorDetailsFromDataManager(actorId: Int) {
        actorDataManager.downloadActorDetailsFromInternet(actorId: actorId) { (error, actor) in
            if let actorDetails = actor {
                self.presenter.showActorDetails(actor: actorDetails)
                self.downloadActorFamousMoviesFromDataManager(imdbId: actorDetails.imdbId!)
            } else {
                self.presenter.provideActorErrorMessageFromInteractor(error!)
            }
        }
    }
    
    private func downloadActorFamousMoviesFromDataManager(imdbId: String) {
        actorDataManager.downloadFamousMoviesForTheActor(imdbId: imdbId) { (error, movies) in
            self.presenter.showActorKnownFromMovies(movies: movies!)
        }
    }


    
}
