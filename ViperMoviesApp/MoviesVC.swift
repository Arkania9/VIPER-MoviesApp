//
//  ViewController.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 03.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import PKHUD

class MoviesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageNumberLbl: UILabel!
    @IBOutlet weak var previousBtnLbl: UIButton!

    var presenter: MoviesPresenterProtocol!
    var movies: [MovieModel] = []
    var currentType = "popular"
    var page = 1
    var totalPages: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        presenter.getDataFromInteractor(movieType: "popular", page: page)
    }
    
    @IBAction func populasPressed(_ sender: UIButton) {
        page = 1
        pageNumberLbl.text = "Page \(page)"
        presenter.getDataFromInteractor(movieType: "popular", page: page)
        currentType = "popular"
    }
    
    @IBAction func topRatedPressed(_ sender: UIButton) {
        page = 1
        pageNumberLbl.text = "Page \(page)"
        presenter.getDataFromInteractor(movieType: "top_rated", page: page)
        currentType = "top_rated"
    }
    
    @IBAction func upcomingPressed(_ sender: UIButton) {
        page = 1
        pageNumberLbl.text = "Page \(page)"
        presenter.getDataFromInteractor(movieType: "upcoming", page: page)
        currentType = "upcoming"
    }
    
    @IBAction func nowPlayingPressed(_ sender: UIButton) {
        page = 1
        pageNumberLbl.text = "Page \(page)"
        presenter.getDataFromInteractor(movieType: "now_playing", page: page)
        currentType = "now_playing"
    }
    
    @IBAction func nextPagePressed(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork() {
            page += 1
            if page > 1 { previousBtnLbl.alpha = 1 }
            pageNumberLbl.text = "Page \(page)"
            presenter.getDataFromInteractor(movieType: currentType, page: page)
        } else {
            showErrorMessage("Check your internet connection")
        }
    }
    
    @IBAction func previousPagePressed(_ sender: UIButton) {
        page -= 1
        if page <= 1 { previousBtnLbl.alpha = 0 }
        pageNumberLbl.text = "Page \(page)"
        presenter.getDataFromInteractor(movieType: currentType, page: page)
    }
    
    @IBAction func searchMoviePressed(_ sender: UIButton) {
        let alertView = UIAlertController(title: "Enter title", message: "We are going to search your movie", preferredStyle: .alert)
        alertView.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter First Name"
        }
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            let searchText = alertView.textFields![0] as UITextField
            self.presenter.getDataFromSearchTextInteractor(searchText: searchText.text!)
        }))
        self.present(alertView, animated: true, completion: nil)
    }
}

extension MoviesVC {
    func showErrorMessage(_ errorMessage: String) {
        let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        present(errorAlert, animated: true, completion: nil)
    }
}


extension MoviesVC: MoviesVCProtocol {
    
    func showMovies(movies: [MovieModel]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showMoviesFromSearchText(movies: [MovieModel]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.pageNumberLbl.text = "Page 1"
        }
    }
    
    func provideMoviesError(_ errorMessage: String) {
        showErrorMessage(errorMessage)
    }

}

extension MoviesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell") as? MoviesCell {
            let movieObj = movies[indexPath.row]
            cell.configureMovies(movie: movieObj)
            return cell
        }
        return UITableViewCell()
    }
}

extension MoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.passMovieToDetailsVC(for: movies[indexPath.row])
    }
}





