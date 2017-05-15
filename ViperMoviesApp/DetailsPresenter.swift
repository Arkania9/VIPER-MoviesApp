//
//  DetailsPresenter.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 04.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation


class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsVCProtocol!
    var wireFrame: DetailsWireFrameProtocol!
    var movie: MovieModel?
    var interactor: DetailsInteractorProtocol!
    
    
    func viewDidLoad() {
        view.showMovieDetailFromPreviousScene(movie: movie!)
        interactor.getVideoKeyFromDataManager(id: (movie?.id)!)
        interactor.getDetailModelFromDataManager(movieId: movie!.id!)
        interactor.getCastModelFromDataManager(movieId: movie!.id!)
    }
    
    func showVideoInWeb(videoModel: VideoModel) {
        view.showWebViewFromVideoUrl(videoModel: videoModel)
    }
    
    func showDetailsModelInView(movieDetails: MovieModel) {
        view.showMovieDetailsDownloaded(movieDetails: movieDetails)
    }
    
    func showCastInTableViewFromInteractor(actors: [ActorModel]) {
        view.showCastInTableView(actors: actors)
    }
    
    func passActorToActorVC(actor: ActorModel) {
        wireFrame.presentActorScreen(from: view, for: actor)
    }
    
    func provideDetailErrorMesageFromInteractor(_ error: NSError) {
        view.provideDetailErrorMessage(error.localizedDescription)
    }
    
    
}
