//
//  ActorPresenter.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 06.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation


class ActorPresenter: ActorPresenterProtocol {
    
    var wireframe: ActorWireFrameProtocol!
    var actor: ActorModel?
    var view: ActorVCProtocol!
    var interactor: ActorInteractorProtocol!
    
    func viewDidLoad() {
        view.showActorFromPreviousScene(actor: actor!)
        interactor.downloadActorDetailsFromDataManager(actorId: actor!.actorId!)

    }
    
    func showActorDetails(actor: ActorModel) {
        view.showDownloadedActorDetails(actor: actor)
    }
    
    func showActorKnownFromMovies(movies: [MovieModel]) {
        view.showActorKnownFromMoviesInCollectionView(movies: movies)
    }
    
    func presentMovieVCPassToWireFrame() {
        wireframe.presentMoviesVC(from: view)
    }
    
    func selectActorFamousMovie(movie: MovieModel) {
        wireframe.presentMovieDetails(from: view, for: movie)
    }
    
    func provideActorErrorMessageFromInteractor(_ error: NSError) {
        view.provideActorErrorMessage(error.localizedDescription)
    }
    
}
