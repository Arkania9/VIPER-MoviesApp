//
//  DetailsVC.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 04.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import PKHUD

class DetailsVC: UIViewController {
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieDescLbl: UITextView!
    @IBOutlet weak var movieCategoryLbl: UILabel!
    @IBOutlet weak var movieVoteLbl: UILabel!
    @IBOutlet weak var movieTaglineLbl: UILabel!
    @IBOutlet weak var movieDateLbl: UILabel!
    @IBOutlet weak var movieProductionLbl: UILabel!
    @IBOutlet weak var movieDurationLbl: UILabel!
    @IBOutlet weak var movieRevenueLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var presenter: DetailsPresenterProtocol!
    var actors: [ActorModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        tableView.tableFooterView = UIView()
        presenter.viewDidLoad()
    }

}


extension DetailsVC: DetailsVCProtocol {
    
    func showMovieDetailFromPreviousScene(movie: MovieModel) {
        DispatchQueue.main.async {
            self.movieTitleLbl.text = movie.title
            self.movieDescLbl.text = movie.overview
            self.movieVoteLbl.text = "\(movie.vote!)"
            self.movieImgView.sd_setImage(with: movie.photoURL as URL) { (image, error, cache, url) in
                self.movieImgView.image = image
            }
        }
    }
    
    func showWebViewFromVideoUrl(videoModel: VideoModel) {
        DispatchQueue.main.async {
            self.myWebView.loadRequest(URLRequest(url: videoModel.videoURL as URL))
        }
    }
    
    func showMovieDetailsDownloaded(movieDetails: MovieModel) {
        DispatchQueue.main.async {
            self.movieCategoryLbl.text = movieDetails.category
            self.movieTaglineLbl.text = movieDetails.tagline
            self.movieDateLbl.text = movieDetails.releaseDate
            self.movieProductionLbl.text = movieDetails.production
            self.movieDurationLbl.text = movieDetails.duration
            self.movieProductionLbl.text = movieDetails.production
            self.movieRevenueLbl.text = movieDetails.boxoffice!
        }
    }
    
    func showCastInTableView(actors: [ActorModel]) {
        self.actors = actors
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func provideDetailErrorMessage(_ errorMessage: String) {
        let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        present(errorAlert, animated: true, completion: nil)
    }
    
}



extension DetailsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsMovieCell") as? DetailsMovieCell {
            let actor = actors[indexPath.row]
            cell.configureCastTableView(actor: actor)
            return cell
        }
        return UITableViewCell()
    }
}


extension DetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.passActorToActorVC(actor: actors[indexPath.row])
    }
}









