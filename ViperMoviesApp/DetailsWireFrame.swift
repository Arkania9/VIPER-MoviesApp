//
//  DetailsWireFrame.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 04.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit


class DetailsWireFrame: DetailsWireFrameProtocol {
    
    
    static func createPostDetailModule(forMovie movie: MovieModel) -> UIViewController {
        let detailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailsController")
        if let view = detailsViewController as? DetailsVC {
            let presenter = DetailsPresenter()
            let wireFrame = DetailsWireFrame()
            let interactor = DetailsInteractor()
            let detailsManager = DetailsDataManager()
            
            view.presenter = presenter
            presenter.view = view
            presenter.movie = movie
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.detailsDataManager = detailsManager
            interactor.presenter = presenter
            
            return detailsViewController
        }
        
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    func presentActorScreen(from view: DetailsVCProtocol, for actor: ActorModel) {
        let actorViewController = ActorWireFrame.createActorModule(actor: actor)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(actorViewController, animated: true)
        }
    }
    
}
