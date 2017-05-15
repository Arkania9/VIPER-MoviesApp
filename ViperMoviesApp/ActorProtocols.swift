//
//  ActorProtocols.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 06.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

//Wireframe
protocol ActorWireFrameProtocol: class {
    static func createActorModule(actor: ActorModel) -> UIViewController
    func presentMoviesVC(from view: ActorVCProtocol)
    func presentMovieDetails(from view: ActorVCProtocol, for movie: MovieModel)
}
//Presenter
protocol ActorPresenterProtocol: class {
    func viewDidLoad()
    func showActorDetails(actor: ActorModel)
    func showActorKnownFromMovies(movies: [MovieModel])
    func presentMovieVCPassToWireFrame()
    func selectActorFamousMovie(movie: MovieModel)
    func provideActorErrorMessageFromInteractor(_ error: NSError)
}
//ViewController
protocol ActorVCProtocol: class {
    func showActorFromPreviousScene(actor: ActorModel)
    func showDownloadedActorDetails(actor: ActorModel)
    func showActorKnownFromMoviesInCollectionView(movies: [MovieModel])
    func presentMovieVCPassToPresenter()
    func provideActorErrorMessage(_ errorMessage: String)
}

//DataManager 
protocol ActorDataManagerProtocol: class {
    func downloadActorDetailsFromInternet(actorId: Int, closure:@escaping (NSError?, ActorModel?) -> Void) -> Void
    func downloadFamousMoviesForTheActor(imdbId: String, closure: @escaping(NSError?, [MovieModel]?) -> Void) -> Void
}

//Interactor 
protocol ActorInteractorProtocol: class {
    func downloadActorDetailsFromDataManager(actorId: Int)

}
