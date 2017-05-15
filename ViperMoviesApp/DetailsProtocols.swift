//
//  DetailsProtocols.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 04.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

//Wireframe
protocol DetailsWireFrameProtocol: class {
    static func createPostDetailModule(forMovie movie: MovieModel) -> UIViewController
    func presentActorScreen(from view: DetailsVCProtocol, for actor: ActorModel)
}
//Presenter
protocol DetailsPresenterProtocol: class {
    func viewDidLoad()
    func showVideoInWeb(videoModel: VideoModel)
    func showDetailsModelInView(movieDetails: MovieModel)
    func showCastInTableViewFromInteractor(actors: [ActorModel])
    func passActorToActorVC(actor: ActorModel)
    func provideDetailErrorMesageFromInteractor(_ error: NSError) 
}
//ViewController
protocol DetailsVCProtocol: class {
    func showMovieDetailFromPreviousScene(movie: MovieModel)
    func showWebViewFromVideoUrl(videoModel: VideoModel)
    func showMovieDetailsDownloaded(movieDetails: MovieModel)
    func showCastInTableView(actors: [ActorModel])
    func provideDetailErrorMessage(_ errorMessage: String)
}
//DataManager
protocol DetailsDataManagerProtocol: class {
    func downloadVideoKeyMovie(id: Int, closure:@escaping (NSError?, VideoModel?) -> Void) -> Void
    func downloadMovieDetails(movieId: Int, closure: @escaping(NSError?, MovieModel?) -> Void) -> Void
    func downloadMovieCast(movieId: Int, closure: @escaping (NSError?, [ActorModel]?) -> Void) -> Void
}
//Interactor
protocol DetailsInteractorProtocol: class {
    func getVideoKeyFromDataManager(id: Int)
    func getDetailModelFromDataManager(movieId: Int)
    func getCastModelFromDataManager(movieId: Int)
}
