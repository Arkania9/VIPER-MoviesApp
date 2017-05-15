//
//  PopularInteractor.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 03.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation

class MoviesInteractor: MoviesInteractorProtocolInput {
    
    var dataManager: MovieDataManager!
    var presenter: MoviesPresenterProtocol!
    
    func getDataFromDataManager(movieType: String, page: Int) {
        dataManager.downloadDataFromInternetAndParseJSON(movieType: movieType, page: page) { (error, allMovies) in
            if let movies = allMovies {
                self.presenter.retriveMoviesToShow(movies: movies)
            } else {
                self.presenter.provideErrorMessageToView(error!)
            }
        }
    }
    
    func getDataFromSearchText(searchText: String) {
        dataManager.downloadDataFromSearchTextAndParseJSON(searchText: searchText) { (error, searchMovies) in
            if let movies = searchMovies {
                self.presenter.retriveMoviesFromSearchTextToShow(movies: movies)
            } else {
                self.presenter.provideErrorMessageToView(error!)
            }
        }
    }
    
}
