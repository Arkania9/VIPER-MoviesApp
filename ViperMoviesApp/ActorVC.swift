//
//  ActorVC.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 06.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class ActorVC: UIViewController {
    @IBOutlet weak var actorImgView: UIImageView!
    @IBOutlet weak var actorNameLbl: UILabel!
    @IBOutlet weak var actorBirthLbl: UILabel!
    @IBOutlet weak var actorBirthPlaceLbl: UILabel!
    @IBOutlet weak var actorBiographyText: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: ActorPresenterProtocol!
    var movies: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        let menuBarButtonItem = UIBarButtonItem(title: "Menu",style: .plain,target: self,action: #selector(presentMovieVCPassToPresenter))
        self.navigationItem.rightBarButtonItem = menuBarButtonItem
        presenter.viewDidLoad()
    }

    
}

extension ActorVC: ActorVCProtocol {
    func showActorFromPreviousScene(actor: ActorModel) {
        DispatchQueue.main.async {
            self.actorNameLbl.text = actor.actorName
            self.actorImgView.sd_setImage(with: actor.photoURL as URL, completed: { (image, error, cache, url) in
                self.actorImgView.image = image
            })
        }
    }
    
    func showDownloadedActorDetails(actor: ActorModel) {
        DispatchQueue.main.async {
            self.actorBiographyText.text = actor.biography
            self.actorBirthPlaceLbl.text = actor.placeOfBirth
            self.actorBirthLbl.text = actor.birthday
        }
    }
    
    func showActorKnownFromMoviesInCollectionView(movies: [MovieModel]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func presentMovieVCPassToPresenter() {
        presenter.presentMovieVCPassToWireFrame()
    }
    
    func provideActorErrorMessage(_ errorMessage: String) {
        let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        present(errorAlert, animated: true, completion: nil)
    }
    
}

extension ActorVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as? ActorCell {
            let movieObj = movies[indexPath.row]
            cell.configureCollectionView(movie: movieObj)
            return cell
        }
        return UICollectionViewCell()
    }
}


extension ActorVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectActorFamousMovie(movie: movies[indexPath.row])
    }
}
















