//
//  PopularProtocols.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 03.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit


protocol MovieDataManagerProtocol: class {
    // DataManager -> Entity
    func downloadDataFromInternetAndParseJSON(movieType: String, page: Int, closure: @escaping (NSError?,[MovieModel]?) -> Void) -> Void
    func downloadDataFromSearchTextAndParseJSON(searchText: String, closure: @escaping (NSError?, [MovieModel]?) -> Void) -> Void
}

protocol MoviesInteractorProtocolInput: class {
    //Interactor -> DataManager
    func getDataFromDataManager(movieType: String, page: Int)
    func getDataFromSearchText(searchText: String)
}

protocol MoviesPresenterProtocol: class {
    //Presenter -> Interactor
    func getDataFromInteractor(movieType: String, page: Int)
    func retriveMoviesToShow(movies: [MovieModel])
    func getDataFromSearchTextInteractor(searchText: String)
    func retriveMoviesFromSearchTextToShow(movies: [MovieModel])
    func passMovieToDetailsVC(for movie: MovieModel)
    func provideErrorMessageToView(_ error: NSError)
}

protocol MoviesVCProtocol: class {
    //View -> Presenter
    func showMovies(movies: [MovieModel])
    func showMoviesFromSearchText(movies: [MovieModel])
    func provideMoviesError(_ errorMessage: String)
}

//Wireframe
protocol MoviesWireFrameProtocol: class {
    static func createMoviesModule() -> UIViewController
    func presentMovieDetailScreen(from view: MoviesVCProtocol, forMovie movie: MovieModel)
}
