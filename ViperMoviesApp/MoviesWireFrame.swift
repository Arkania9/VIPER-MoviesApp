//
//  PopularWireFrame.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 03.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit


class MoviesWireFrame: MoviesWireFrameProtocol {


    class func createMoviesModule() -> UIViewController {
        
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MoviesNavigationController")
        if let view = navController.childViewControllers.first as? MoviesVC {
            let dataManager = MovieDataManager()
            let interactor = MoviesInteractor()
            let presenter = MoviesPresenter()
            let wireframe = MoviesWireFrame()
            
            interactor.dataManager = dataManager
            interactor.presenter = presenter
            presenter.interactor = interactor
            presenter.view = view
            presenter.wireframe = wireframe
            view.presenter = presenter
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    func presentMovieDetailScreen(from view: MoviesVCProtocol, forMovie movie: MovieModel) {
        let postDetailViewController = DetailsWireFrame.createPostDetailModule(forMovie: movie)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
    
}
