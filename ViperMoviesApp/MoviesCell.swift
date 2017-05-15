//
//  PopularMoviesCell.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 04.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class MoviesCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieVote: UILabel!

    func configureMovies(movie: MovieModel) {
        movieImage.alpha = 0
        movieImage.sd_setImage(with: movie.photoURL as URL, completed: { (image, error, cache, url) in
            self.movieImage.image = image
            UIView.animate(withDuration: 0.2, animations: { 
                self.movieImage.alpha = 1.0
            })
        })
        movieTitle.text = movie.title
        movieOverview.text = movie.overview
        movieVote.text = "\(movie.vote!)"
    }
    
}
