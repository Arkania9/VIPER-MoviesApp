//
//  DetailsInteractor.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 04.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation


class DetailsInteractor: DetailsInteractorProtocol {
    
    var detailsDataManager: DetailsDataManagerProtocol!
    var presenter: DetailsPresenterProtocol!
    
    func getVideoKeyFromDataManager(id: Int) {
        detailsDataManager.downloadVideoKeyMovie(id: id) { (error, videoModel) in
            if let currentMovieVideo = videoModel {
                self.presenter.showVideoInWeb(videoModel: currentMovieVideo)
            }
        }
    }
    
    func getDetailModelFromDataManager(movieId: Int) {
        detailsDataManager.downloadMovieDetails(movieId: movieId) { (error, detailModel) in
            if let detailMovies = detailModel {
                self.presenter.showDetailsModelInView(movieDetails: detailMovies)
            } else {
                self.presenter.provideDetailErrorMesageFromInteractor(error!)
            }
        }
    }
    
    func getCastModelFromDataManager(movieId: Int) {
        detailsDataManager.downloadMovieCast(movieId: movieId) { (error, actors) in
            if let actors = actors {
                self.presenter.showCastInTableViewFromInteractor(actors: actors)
            } 
        }
    }
    
}
