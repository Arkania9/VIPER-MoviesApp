//
//  PopularPresenter.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 03.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation

class MoviesPresenter: MoviesPresenterProtocol {
    
    var interactor: MoviesInteractorProtocolInput!
    var view: MoviesVCProtocol!
    var wireframe: MoviesWireFrameProtocol!
    
    func getDataFromInteractor(movieType: String, page: Int) {
        interactor.getDataFromDataManager(movieType: movieType, page: page)
    }
    
    func retriveMoviesToShow(movies: [MovieModel]) {
        view.showMovies(movies: movies)
    }
    
    func getDataFromSearchTextInteractor(searchText: String) {
        interactor.getDataFromSearchText(searchText: searchText)
    }
    
    func retriveMoviesFromSearchTextToShow(movies: [MovieModel]) {
        view.showMoviesFromSearchText(movies: movies)
    }
    
    func passMovieToDetailsVC(for movie: MovieModel) {
        wireframe.presentMovieDetailScreen(from: view, forMovie: movie)
    }
    
    func provideErrorMessageToView(_ error: NSError) {
        view.provideMoviesError(error.localizedDescription)
    }
    
}
