//
//  ActorWireFrame.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 06.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit


class ActorWireFrame: ActorWireFrameProtocol {
    
    static func createActorModule(actor: ActorModel) -> UIViewController {
        let actorViewController = mainStoryboard.instantiateViewController(withIdentifier: "ActorViewController")
        if let view = actorViewController as? ActorVC {
            let presenter = ActorPresenter()
            let wireframe = ActorWireFrame()
            let interactor = ActorInteractor()
            let actordataManager = ActorDataManager()
            
            interactor.presenter = presenter
            interactor.actorDataManager = actordataManager
            presenter.interactor = interactor
            presenter.wireframe = wireframe
            presenter.actor = actor
            presenter.view = view
            view.presenter = presenter
            
            
            return actorViewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentMoviesVC(from view: ActorVCProtocol) {
        let movieViewController = MoviesWireFrame.createMoviesModule()
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.show(movieViewController, sender: nil)
        }
    }
    
    func presentMovieDetails(from view: ActorVCProtocol, for movie: MovieModel) {
        let detailsViewController = DetailsWireFrame.createPostDetailModule(forMovie: movie)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
}
